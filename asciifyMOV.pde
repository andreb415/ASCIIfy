// the image to asciify
import processing.video.*;
Movie movie;

// sampling resolution: colors will be sampled every n pixels 
// to determine which character to display
int resolution = 15; //default 9

// array to hold characters for pixel replacement
char[] ascii;

void setup() {
  movie = new Movie(this, "walkmov.mp4");
  movie.loop();
  size(700,700);
  //fullScreen();
  //img.resize(1000, 0);
  background(0);
  fill(255);
  noStroke();

  // build up a character array that corresponds to brightness values
  ascii = new char[256];
  String letters = "#&MN3S$EUVLOI*<~-?!/;^_¹'·¸. ";   //*×=>»~¬-¦¡;¹'·¸ | MN@#$o;:,. |  ·'¹;¦^¡-~¬=×*+$#@
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }

  PFont mono = createFont("Courier", resolution + 1);
  textFont(mono);

  
}

void asciify() {
  // since the text is just black and white, converting the image
  // to grayscale seems a little more accurate when calculating brightness
  movie.filter(GRAY);
  movie.loadPixels();

  // grab the color of every nth pixel in the image
  // and replace it with the character of similar brightness
  for (int y = 0; y < movie.height; y += resolution) {
    for (int x = 0; x < movie.width; x += resolution) {
      color pixel = movie.pixels[y * movie.width + x];
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
  
}
void movieEvent(Movie movie) {
  movie.read();
}
void draw() {
 
  
  asciify();
  
  //saveFrame("mov/c1.png");
}
