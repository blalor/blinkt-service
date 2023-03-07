module github.com/blalor/blinkt-service

require (
	github.com/alexellis/blinkt_go v0.0.0-20180120180744-cc0ca163e0bc
	github.com/jessevdk/go-flags v1.4.0
	github.com/onsi/ginkgo v1.7.0
	github.com/onsi/gomega v1.4.3
	github.com/sirupsen/logrus v1.9.0
	github.com/vektra/mockery v0.0.0-20181123154057-e78b021dcbb5
)

require (
	github.com/golang/protobuf v1.3.0 // indirect
	github.com/hpcloud/tail v1.0.0 // indirect
	github.com/kr/pretty v0.1.0 // indirect
	golang.org/x/net v0.0.0-20190228165749-92fc7df08ae7 // indirect
	golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8 // indirect
	golang.org/x/text v0.3.1-0.20180807135948-17ff2d5776d2 // indirect
	gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 // indirect
	gopkg.in/fsnotify.v1 v1.4.7 // indirect
	gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 // indirect
	gopkg.in/yaml.v2 v2.2.2 // indirect
)

// looks like a couple of issues in 1.12 related to go.mod parsing:
// * https://github.com/go-resty/resty/issues/230#issuecomment-467911306
replace github.com/go-resty/resty => gopkg.in/resty.v1 v1.12.0

// * https://github.com/golang/lint/issues/436#issuecomment-468450096
replace github.com/golang/lint => github.com/golang/lint v0.0.0-20190227174305-8f45f776aaf1
