package main

import (
    "encoding/json"
    "fmt"
    stdlog "log"
    "net"
    "net/http"
    "os"
    "syscall"
    "time"
    
    flags "github.com/jessevdk/go-flags"
    log "github.com/sirupsen/logrus"
)

var version string = "undef"

type Options struct {
    Debug bool     `env:"DEBUG"    long:"debug"    description:"enable debug"`
    LogFile string `env:"LOG_FILE" long:"log-file" description:"path to JSON log file"`
    
    SocketPath string `long:"socket-path" required:"true"`
}

type statusWriter struct {
    http.ResponseWriter
    status int
    length int
}

func (w *statusWriter) WriteHeader(status int) {
    w.status = status
    w.ResponseWriter.WriteHeader(status)
}

func (w *statusWriter) Write(b []byte) (int, error) {
    if w.status == 0 {
        w.status = 200
    }
    w.length = len(b)
    return w.ResponseWriter.Write(b)
}

// https://github.com/ajays20078/go-http-logger/blob/master/httpLogger.go
func RequestLogger(handler http.Handler) http.Handler {
    logger := log.WithField("name", "http")
    
    return http.HandlerFunc(func(resp http.ResponseWriter, req *http.Request) {
        start := time.Now()

        writer := statusWriter{resp, 0, 0}
        handler.ServeHTTP(&writer, req)
        
        end := time.Now()
        latency := end.Sub(start)

        statusCode := writer.status
        length := writer.length

        logger.Infof(
            "%s %s \"%s %s?%s %s\" %d %d \"%s\" %v",
            req.Host,
            req.RemoteAddr,
            req.Method,
            req.URL.Path,
            req.URL.RawQuery,
            req.Proto,
            statusCode,
            length,
            req.Header.Get("User-Agent"),
            latency,
        )
    })
}

type Led struct {
    index int `json:"-"`
    
    Red        int     `json:"red"`
    Green      int     `json:"green"`
    Blue       int     `json:"blue"`
    Brightness float64 `json:"brightness"`
}

type LedHandler struct {
    Index int
    Ch    chan <-Led
}

func (self LedHandler) ServeHTTP(resp http.ResponseWriter, req *http.Request) {
    switch req.Method {
        // case "GET":
        //     fmt.Fprintln(resp, "ok")
        
        case "PUT":
            var led Led
            
            dec := json.NewDecoder(req.Body)
            dec.DisallowUnknownFields()
            
            if err := dec.Decode(&led); err != nil {
                log.Errorf("decoding body: %v", err)
                resp.WriteHeader(http.StatusBadRequest)
            } else {
                led.index = self.Index
                
                log.Debugf("led payload: %#v", led)
                
                self.Ch <- led
                
                resp.WriteHeader(http.StatusNoContent)
            }
        
        default:
            resp.WriteHeader(http.StatusMethodNotAllowed)
    }
}

func main() {
    var opts Options
    
    _, err := flags.Parse(&opts)
    if err != nil {
        os.Exit(1)
    }
    
    if opts.Debug {
        log.SetLevel(log.DebugLevel)
    }
    
    if opts.LogFile != "" {
        logFp, err := os.OpenFile(opts.LogFile, os.O_WRONLY | os.O_APPEND | os.O_CREATE, 0600)
        checkError(fmt.Sprintf("error opening %s", opts.LogFile), err)
        
        defer logFp.Close()
        
        // ensure panic output goes to log file
        syscall.Dup2(int(logFp.Fd()), 1)
        syscall.Dup2(int(logFp.Fd()), 2)
        
        // log as JSON
        log.SetFormatter(&log.JSONFormatter{})
        
        // send output to file
        log.SetOutput(logFp)
    }
    
    log.Debug("hi there! (tickertape tickertape)")
    log.Infof("version: %s", version)
    
    listener, err := net.Listen("unix", opts.SocketPath)
    checkError("listening", err)
    
    ledChan := make(chan Led)
    go func() {
        for {
            led := <-ledChan
            log.Infof("will update led: %v", led)
        }
    }()
    
    mux := http.NewServeMux()
    for i := 0; i < 8; i++ {
        mux.Handle(fmt.Sprintf("/led/%d", i), LedHandler{i, ledChan})
    }
    
    server := http.Server{
        ReadHeaderTimeout: 10 * time.Second,
        WriteTimeout: 10 * time.Second,
        Handler: RequestLogger(mux),
        ErrorLog: stdlog.New(log.WithField("name", "httpServer").Writer(), "", 0),
    }
    
    server.Serve(listener)
}
