void setup() {
  size(400, 300);
  
}

void draw() {

    background(220, 220, 220);
    
    // circulo grande
    fill(220, 220, 220);
    stroke(0, 0, 256);
    circle(200, 150, 200);
    
    
    // circulo pequeno
    fill(220, 220, 220);
    stroke(0, 0, 256);
    pushMatrix();
    translate(200, 150);
    rotate(radians(frameCount * 1.5 % 360));
    circle(75, 0, 50);
    
    // ponto
    stroke(256,0,0);
    fill(256, 0, 0);
    pushMatrix();
    translate(75, 0);
    rotate(radians(frameCount * 1.5  % 360));
    circle(25, 0, 3);
    popMatrix();
    
    popMatrix();
           
    
}
