# TrafficTrailer
Trailer script for FiveM, specifically designed to work with the "DOT Message Board Trailer" from Redneck Modifications.

[DOT Message Board Trailer on RedneckMods.com](https://www.redneckmods.com/package/5045763)

The script allows you to turn the sign on/off, rotate it, and change the message all from within your vehicle or while standing in front of it.

## Commands
Enter these commands in the chat window.  All commands show a hint within the chat window to help you.

- **/trrotate** - rotates the sign
- **/trsignon** - turns on the sign
- **/trsignoff** - turns off the sign
- **/trattach** - attach the trailer to your vehicle
- **/trsign1** to **/trsign12** - switch to the specified message *(will automatically turn on the sign if it's not already on)*

## Notes / Known Issues
- When you have the sign rotated and switch to a different message (e.g. /trsign3), you'll see the animation for the sign rotating again after the message changes.  This is out of my control.  It has to do with how Extras are turned on & off when switching the message.
- For the script to work, the trailer must be behind your vehicle OR you must be facing the trailer if on foot
- The angle of the trailer compared to your vehicle/ped may prevent the script from working.  If you try a command and you get notified that the trailer could not be found, try moving your vehicle to a different angle from the trailer.  Straight on (directly in front of) the trailer should always work.
- There is no /trdetach command because the default button (press & hold H) seems to work fine.  In my experience, the attaching did not work automatically so I added the attach command.
