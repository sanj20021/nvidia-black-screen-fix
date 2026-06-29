so I had this extremely annoying issue with my RTX 4070 where I would connect my TV or PC monitor and if I left it alone for a while, the screen just wouldn't wake up when moving the mouse. the weird part was the PC was definitely still running - RAM RGB and CPU cooler lights were on, fans were spinning, but screen stayed black. 

turns out it's a known handshake bug. the PC wasn't actually sleeping, Windows was just turning off the display. if it's off for a long time, the monitor goes into a deep standby. when you move the mouse, the NVIDIA GPU driver tries to wake it, but because the monitor is in deep standby it doesn't reply fast enough. the driver panics, throws a timeout error and completely crashes. that's why the screen stays black but the PC is still running.

I made these two scripts to diagnose and fix it completely.

### what the fix does
instead of letting the display turn off (and crashing the connection), it sets Windows to NEVER turn off the display. instead, it enables the native blank black Windows screensaver to kick in after 5 minutes. this turns off the pixels on your screen so it saves power and stops burn-in, but keeps the HDMI connection alive so the driver never crashes. it also disables PCIe link state power management just to be safe.

### files
- **diagnose_nvidia_issue.ps1** - run this first. it checks your Windows Event logs for `nvlddmkm` crashes (Event 153/13) to see if you have this exact bug.
- **fix_nvidia_black_screen.ps1** - run this to apply the fixes automatically.

### how to use
right click the script you want to run and select "Run with PowerShell". 

hope this saves someone the headache I had!
