// the image to asciify
PImage img;

// sampling resolution: colors will be sampled every n pixels 
// to determine which character to display
int resolution = 7; //default 9

// array to hold characters for pixel replacement
char[] ascii;

void setup() {
  img = loadImage("f (18).gif");
  size(700,700);
  //fullScreen();
  //img.resize(1000, 0);
  background(255);
  fill(0);
  noStroke();

  // build up a character array that corresponds to brightness values
  ascii = new char[256];
  String letters = "#&MN3S$EUVLOI*<~-?!/;^_¹'·¸. ";   //*×=>»~¬-¦¡;¹'·¸ | MN@#$o;:,. |  ·'¹;¦^¡-~¬=×*+$#@
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }

  PFont mono = createFont("Courier", resolution + 3);
  textFont(mono);

  asciify();
}

void asciify() {
  // since the text is just black and white, converting the image
  // to grayscale seems a little more accurate when calculating brightness
  img.filter(GRAY);
  img.loadPixels();

  // grab the color of every nth pixel in the image
  // and replace it with the character of similar brightness
  for (int y = 0; y < img.height; y += resolution) {
    for (int x = 0; x < img.width; x += resolution) {
      color pixel = img.pixels[y * img.width + x];
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
  saveFrame("bike2/c36.png");
}
