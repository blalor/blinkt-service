module github.com/blalor/blinkt-service

require (
	github.com/alexellis/blinkt_go v0.0.0-20180120180744-cc0ca163e0bc
	github.com/jessevdk/go-flags v1.4.0
	github.com/onsi/ginkgo v1.7.0
	github.com/onsi/gomega v1.27.7
	github.com/sirupsen/logrus v1.3.0
	github.com/vektra/mockery v0.0.0-20181123154057-e78b021dcbb5
)

require (
	github.com/fsnotify/fsnotify v1.4.7 // indirect
	github.com/google/go-cmp v0.5.9 // indirect
	github.com/hpcloud/tail v1.0.0 // indirect
	github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect
	github.com/kr/pretty v0.1.0 // indirect
	github.com/stretchr/testify v1.3.0 // indirect
	golang.org/x/crypto v0.0.0-20190228161510-8dd112bcdc25 // indirect
	golang.org/x/net v0.10.0 // indirect
	golang.org/x/sys v0.8.0 // indirect
	golang.org/x/text v0.9.0 // indirect
	gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 // indirect
	gopkg.in/fsnotify.v1 v1.4.7 // indirect
	gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)

// looks like a couple of issues in 1.12 related to go.mod parsing:
// * https://github.com/go-resty/resty/issues/230#issuecomment-467911306
replace github.com/go-resty/resty => gopkg.in/resty.v1 v1.12.0

// * https://github.com/golang/lint/issues/436#issuecomment-468450096
replace github.com/golang/lint => github.com/golang/lint v0.0.0-20190227174305-8f45f776aaf1
