# m5proHomeAssistant
A very crude "integration" for M5 Pro in Home Assistant

Upload m5Pro.sh to /config/shell/m5Pro.sh

In configuration.yaml add a shell command to issue commands to device and retreive status.

EXAMPLE(for some reason carrige returns aren't showing. view in raw for proper format):
shell_command:  
  5mprostatus: bash /config/shell/5mPro.sh status yourM5IPAddress
  5mprolighttoggle: bash /config/shell/5mPro.sh lightToggle yourM5IPAddress
  5mprostop: bash /config/shell/5mPro.sh stop yourM5IPAddress
  5mpropause: bash /config/shell/5mPro.sh pause yourM5IPAddress
  5mproresume: bash /config/shell/5mPro.sh resume yourM5IPAddress
  5mprohome: bash /config/shell/5mPro.sh home yourM5IPAddress

Call status in a automation with a time pattern condition to match your needs.
