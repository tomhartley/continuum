PShader blur;
PGraphics src;
PGraphics pass1, pass2;

void setup_red()
{
  blur = loadShader("blur.glsl");
  blur.set("blurSize", height / 8);
  blur.set("sigma", 10.0f);  
  
  src = createGraphics(width, height, P3D); 
  
  pass1 = createGraphics(width, height, P2D);
  pass1.noSmooth();  
  
  pass2 = createGraphics(width, height, P2D);
  pass2.noSmooth();
  
}

void draw_red()
{
  if (setup_fin == false) {
    setup_red();
    setup_fin = true;
  }
  float t = millis() * 0.001;
  randomSeed(0);
  
  src.beginDraw();
  src.noStroke();
  src.background(255, 0, 0);
  src.fill(255, 150);
  src.blendMode(NORMAL);

  src.directionalLight(255, 255, 255, -1, 0, 0.4);
  src.directionalLight(50, 50, 50, -1, 0, 0.2);
  src.directionalLight(50, 50, 50, -1, 0, 0);
  src.directionalLight(255, 0, 0, 1, 0, 0);

  // Lots of rotating cubes
  for (int i = 0; i < 80; i++) {
    src.pushMatrix();

    // This part is the chaos demon.
    src.translate(map(noise(random(1000), t * 0.07), 0, 1, -width, width*2),
      map(noise(random(1000), t * 0.07), 0, 1, -height, height*2), 0);

    // Progression of time
    src.rotateY(t * 0.4 + randomGaussian());
    src.rotateX(t * 0.122222 + randomGaussian());

    // But of course.
    src.box(height * abs(0.2 + 0.2 * randomGaussian()));
    src.popMatrix();
  }

  // Brighten if we care
  /*
  src.noLights();
  src.blendMode(ADD);
  src.fill(40, 0, 0);
  src.rect(0, 0, width, height);
  */

  // Separable blur filter
  src.endDraw();

  blur.set("horizontalPass", 0);
  pass1.beginDraw();            
  pass1.shader(blur);  
  pass1.image(src, 0, 0);
  pass1.endDraw();
  
  blur.set("horizontalPass", 1);
  pass2.beginDraw();            
  pass2.shader(blur);  
  pass2.image(pass1, 0, 0);
  pass2.endDraw();    
        
  image(pass2, 0, 0);
}

