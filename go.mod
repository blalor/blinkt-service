module github.com/blalor/blinkt-service

require (
	github.com/alexellis/blinkt_go v0.0.0-20180120180744-cc0ca163e0bc
	github.com/jessevdk/go-flags v1.5.0
	github.com/onsi/ginkgo v1.16.5
	github.com/onsi/gomega v1.10.1
	github.com/sirupsen/logrus v1.3.0
)

require (
	github.com/fsnotify/fsnotify v1.4.9 // indirect
	github.com/go-task/slim-sprig v0.0.0-20210107165309-348f09dbbbc0 // indirect
	github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect
	github.com/kr/pretty v0.1.0 // indirect
	github.com/nxadm/tail v1.4.8 // indirect
	golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9 // indirect
	golang.org/x/net v0.0.0-20201021035429-f5854403a974 // indirect
	golang.org/x/sys v0.0.0-20210320140829-1e4c9ba3b0c4 // indirect
	golang.org/x/text v0.3.3 // indirect
	golang.org/x/tools v0.0.0-20201224043029-2b0845dc783e // indirect
	golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1 // indirect
	gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 // indirect
	gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7 // indirect
	gopkg.in/yaml.v2 v2.3.0 // indirect
)

// looks like a couple of issues in 1.12 related to go.mod parsing:
// * https://github.com/go-resty/resty/issues/230#issuecomment-467911306
replace github.com/go-resty/resty => gopkg.in/resty.v1 v1.12.0

// * https://github.com/golang/lint/issues/436#issuecomment-468450096
replace github.com/golang/lint => github.com/golang/lint v0.0.0-20190227174305-8f45f776aaf1
