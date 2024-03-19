# m5proHomeAssistant
A very crude "integration" for M5 Pro in Home Assistant

Upload m5Pro.sh to /config/shell/m5Pro.sh

In config.yaml add a shell command to issue commands to device and retreive status.

EXAMPLE:

5mprostatus: bash /config/shell/5mPro.sh status ip_Address_Here
5mprolighttoggle: bash /config/shell/5mPro.sh lightToggle ip_Address_Here
5mprostop: bash /config/shell/5mPro.sh stop ip_Address_Here
5mpropause: bash /config/shell/5mPro.sh pause ip_Address_Here
5mproresume: bash /config/shell/5mPro.sh resume ip_Address_Here
5mprohome: bash /config/shell/5mPro.sh home ip_Address_Here

Call status in a automation with a time pattern condition to match your needs.
