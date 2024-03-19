# m5proHomeAssistant
A very crude "integration" for M5 Pro in Home Assistant

Upload m5Pro.sh to /config/shell/m5Pro.sh

In configuration.yaml add a shell command to issue commands to device and retreive status.

EXAMPLE(for some reason carrige returns aren't showing. view in raw for proper format):
m5proIPAddress: 127.0.0.1
shell_command:  
  5mprostatus: bash /config/shell/5mPro.sh status var(m5proIPAddress)
  5mprolighttoggle: bash /config/shell/5mPro.sh lightToggle var(m5proIPAddress)
  5mprostop: bash /config/shell/5mPro.sh stop var(m5proIPAddress)
  5mpropause: bash /config/shell/5mPro.sh pause var(m5proIPAddress)
  5mproresume: bash /config/shell/5mPro.sh resume var(m5proIPAddress)
  5mprohome: bash /config/shell/5mPro.sh home var(m5proIPAddress)

Call status in a automation with a time pattern condition to match your needs.
