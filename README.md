This could be checked into github, but we have currently used up all our private repositories.

indicatord - is a sinatra app (running as root) that drives the usb delcom light
jenkins_light -  monitors the jenkins ci view running on JENKINS_URL and modifies the indicator light by sending get requests to the sinatra app

TODO:
  for some reason the bin/indicatord isn't working, so instead its running with the following file:

  :::: /usr/local/bin/indicatord ::::
  #!/bin/sh
  ruby /home/ci/dev/indicator/bin/indicatord
  :::: /usr/local/bin/indicatord ::::

