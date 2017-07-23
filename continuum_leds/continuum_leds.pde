boolean setup_fin = false;

void setup()
{
  setup_env(8); //The 8 is a scale factor. At 1, it's 2440 x 2000. At 10, it's 240 x 200.
}

int h_wipe = 0;
boolean hor_wipe(color c) {
  fill(c);
  rect(0, 0, h_wipe, height);
  h_wipe+=1;
  if (h_wipe>width) {
    h_wipe = 0;
    return true;
  } else {
    return false;
  }
}

int v_wipe = 0;
boolean ver_wipe(color c) {
  fill(c);
  rect(0, 0, width, v_wipe);
  v_wipe += 1;
  if (v_wipe>height) {
    v_wipe = 0;
    return true;
  } else {
    return false;
  }
}


int state = 0;

void draw_test() {
  background(color(125,125,125));
  
  switch(state) {
  case 0: 
    if (ver_wipe(color(255,0,0))) state = 1;
    println(state);
    break;
  case 1:
    if (hor_wipe(color(0,255,0))) state = 2;
    break;
  case 2: 
    if (ver_wipe(color(0,0,255))) state = 3;
    break;
  case 3: 
    if (hor_wipe(color(255,0,0))) state = 4;
    break;
  case 4: 
    if (ver_wipe(color(0,255,0))) state = 5;
    break;
  case 5: 
    if (hor_wipe(color(0,0,255))) state = 0;
    break;
  default:
    state = 0;
    break;
  }
  
}

void draw() {
  opc.showLocations(false);
  
  //**************** Comment out all but one of the following lines *********
  //draw_test(); //RGB wipe, looks horrible, good for testing.
  draw_red(); //Blurry red blobs that move and do cool stuff. Could try make blue?
  //draw_clouds(); //cloudy thing that floats across whispily
  
}
