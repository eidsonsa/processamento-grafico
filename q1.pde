// state
float radius = 30;
float circleX = radius;
float circleY = 200 - radius;
float g = 0.5;
float vx = 5;
float vy = 10;

// frameRate = 10 fps
// 4s = 40 frames -> 20 ida 20 volta
// 500 uc / 20 frames = 25 uc/frame velocidade vertical 

void setup() {
  size(600, 400);

}

void draw() {
  // clear out old frames
    background(220, 220, 220);
    fill(256, 0, 0);
    rect(0, 200, 600, 400);
    
    
    fill(0, 0, 250);
    ellipse(circleX, circleY, 60, 60);
    
    vy += g;
    circleX += vx;
    circleY -= vy;
    
    if (circleY < 200 || circleY > 600){
      vy *= -1;
    }
    
    if (circleX > width || circleX < 0) {
      vx *= -1;
    }
    


  // draw current frame based on state


  // modify state
  //circleY = circleY + 1;

  //// reset state
  //if(circleY > height) {
  //  circleY = 0;
  //}
}
