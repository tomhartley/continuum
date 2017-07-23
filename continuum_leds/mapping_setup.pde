OPC opc;
Table table;
PImage img;
float dx, dy, dz;

int[] blankLEDs = {};

void setup_env(int scale) {
  size(2440/scale, 2000/scale, P2D);
  opc = new OPC(this, "127.0.0.1", 7890);
  
  table = loadTable("led_csv.csv", "header");

  int curStrip = 0;
  int curPos = 0;
  int mappedLEDs = 0;
  
  for (TableRow row : table.rows()) {
    
    int fc_id = row.getInt(0)-1; //Workaround for bug in proc
    int striplen = row.getInt("len");
    int s_x = row.getInt("s_x") / scale;
    int s_y = height-(row.getInt("s_y") / scale);
    int e_x = row.getInt("e_x") / scale;
    int e_y = height-(row.getInt("e_y") / scale);
    
    String fc_con = row.getString("fc_con");
    char con = fc_con.charAt(0);
    int conInt = int(con)-65; //65 is the pos of A in ASCII
    //conInt = 0, 1, 2.. etc
    
    int newStrip = conInt + 8*fc_id; //0-15
    if (newStrip != curStrip) {
      curStrip = newStrip;
      curPos = 0; //this is the next led to hit
    }
    
    float d_x, d_y;
    if (striplen==1) {
      d_x = 0;
      d_y = 0;
    } else {  
      d_x = float(e_x-s_x)/(striplen-1);
      d_y = float(e_y-s_y)/(striplen-1);
    }
  
    
    for (int i = 0; i<(striplen*2-1); i++) {
      int lednum = curStrip * 64 + curPos + i;
      //println (lednum);
      if (i%2 == 1) {
        //the off LEDs
        blankLEDs = append(blankLEDs,lednum);
        //print ("yo");
        continue;
      }
      println (lednum);
      
      int led_x = int(d_x*(i/2)+s_x);
      int led_y = int(d_y*(i/2)+s_y);
      
      opc.led(lednum,led_x,led_y);
      mappedLEDs+=1;
    }
    curPos+=striplen*2-1;
    
  }
  opc.setStatusLed(false);
}
