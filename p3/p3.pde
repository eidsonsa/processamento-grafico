PImage img; 

void setup() {
  size(600, 600);
  img = loadImage("/Texturas/char1_d.png");
}

void draw() {
  background(0);
  image(img,0,0);
}
