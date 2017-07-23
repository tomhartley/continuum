README

First install Processing - I used 2.2.1 so that's probably safest.

Then, download the fadecandy package. In the bin folder of this package are 3 binaries: fcserver-osx, fcserver.exe or fcserver-rpi.

To start the server, execute it as normal from command line, but as the first argument pass the path of the config.json file in this zip. e.g. when I run it it's something like this:

./fcserver-osx /Users/tom/Documents/Continuum/final_layout/continuum_leds/config.json

The default config only allows one fadecandy, but this config tells fadecandy to map the first candy (with the '1' sticker on it) to LEDs 0-511 and device 2 to LEDs 512-1023.

You can then open the continuum_leds.pde file in Processing and run it. Uncomment various lines in the draw() function at the bottom of the continuum_leds file to get the code to do different things. By default it runs a test script that wipes across the board in R,G,B both horizontally and vertically.

When editing the led_csv.csv file to define the positions of LEDs in their strips, the following format is used:

terminology: 
- a strip is one continuous section of straight LEDs (no solder joints).
- a run is a collection of strips in succession.

Col 1. Fadecandy id. This is currently 1 for the left board, and 2 for the right board.
Col 2. Fadecandy connection. This is which connection on the fadecandy this is a part of. EG, C is connection 2 (as it's 0 indexed)
Col 3. Index. In each run of a couple of strips chained together, this indicates which strip we're currently on.
Col 4. Len. How many LEDs are in that strip?
Col 5. Start position x value of that strip, in mm from the bottom left of the boards
Col 6. Start position y value
Col 7. End position x value
Col 8. End position y value

There are several restrictions. Due to the way the code that reads the file works, the rows need to sorted first by fadecandy id, then by fadecandy connection, then by index. Check the current led_csv.csv file and this should be obvious. 
