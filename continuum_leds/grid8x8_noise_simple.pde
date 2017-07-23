// A simple example of using Processing's noise() function to draw LED clouds

PImage clouds;

void setup_clouds()
{
  colorMode(HSB, 100);
  noiseDetail(5, 0.4);
  loadPixels();

  // Render the noise to a smaller image, it's faster than updating the entire window.
  clouds = createImage(128, int(128*(float(height)/width)), RGB);
}

void draw_clouds()
{
  if (setup_fin == false) {
    setup_clouds();
    setup_fin = true;
  }

  float hue = (noise(millis() * 0.0001) * 200) % 100;
  float z = millis() * 0.0001;
  float dx = millis() * 0.0001;

  for (int x=0; x < clouds.width; x++) {
    for (int y=0; y < clouds.height; y++) {
      float n = 500 * (noise(dx + x * 0.01, y * 0.01, z) - 0.4);
      color c = color(hue, 80 - n, n);
      clouds.pixels[x + clouds.width*y] = c;
    }
  }
  clouds.updatePixels();

  image(clouds, 0, 0, width, height);
}

