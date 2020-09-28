void setup() {
  size(400, 300);
  frameRate(30);
  
}

void draw() {

    background(220, 220, 220);
    
    // circulo grande
    fill(220, 220, 220);
    stroke(0, 0, 256);
    circle(200, 150, 200);
    
    
    // 120 frames = 2 pi
    // 1 frame = 2 pi / 120
    // 360 / 120 = 3
    
    
    
    // circulo pequeno
    fill(220, 220, 220);
    stroke(0, 0, 256);
    pushMatrix();
    translate(200, 150);
    rotate(radians(-frameCount * 3 % 360));
    circle(75, 0, 50);
    
    // ponto
    stroke(256,0,0);
    fill(256, 0, 0);
    pushMatrix();
    translate(75, 0);
    rotate(radians(-frameCount * 12 % 360));
    circle(25, 0, 3);
    popMatrix();
    
    popMatrix();
           
    
}
