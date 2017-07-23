README

First install Processing - I used 2.2.1 so that's probably safest.

Then, download the fadecandy package. In the bin folder of this package are 3 binaries: fcserver-osx, fcserver.exe or fcserver-rpi.

To start the server, execute it as normal from command line, but as the first argument pass the path of the config.json file in this zip. e.g. when I run it it's something like this:

./fcserver-osx /Users/tom/Documents/Continuum/final_layout/continuum_leds/config.json

The default config only allows one fadecandy, but this config tells fadecandy to map the first candy (with the '1' sticker on it) to LEDs 0-511 and device 2 to LEDs 512-1023.

You can then open the continuum_leds.pde file in Processing and run it. Uncomment various lines in the draw() function at the bottom of the continuum_leds file to get the code to do different things. By default it runs a test script that wipes across the board in R,G,B both horizontally and vertically.
