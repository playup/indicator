indicatord - is a sinatra app (running as root) that drives the usb delcom light
jenkins_light -  monitors the jenkins ci view running on JENKINS_URL and modifies the indicator light by sending get requests to the sinatra app

Works under linux (tested under Ubuntu 10.04)

### Installing under Ubuntu
```
sudo apt-get install libusb-dev
```

```
sudo gem install indicator_delcom
```

TODO: rename this repo
