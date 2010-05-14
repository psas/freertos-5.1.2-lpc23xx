
 openocd -f interface/olimex-arm-usb-ocd.cfg -f target/lpc2378.cfg

telnet localhost 4444

script oocd_flash_lpc2378_v1292_RollControl.script
