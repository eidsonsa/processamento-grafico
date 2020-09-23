void setup() {
  size(700, 700, P3D);
  
}

void draw() {

    background(256, 256, 256);
    
    stroke(0, 0, 256);
    line(350, 0, 350, 350);
       
    pushMatrix();
    translate(350, 350, 0); 
  

    rotateX(radians(60));
  
    stroke(256, 0, 0);
    line(0, 0, 350, 0);
    stroke(0, 0, 0);
    rect(0, -200, 200, 200);
    stroke(0, 0, 0);
    circle(100, -100, 200);
    stroke(0, 0, 0);
    circle(100, -100, 2);
    
    stroke(0, 0, 0);
    pushMatrix();
    translate(100, -100, 0);
    rotateX(radians(-60));
    rotateY(radians(frameCount * 1.5 % 360));
    rotateZ(radians(frameCount * 1.5 % 360));
    rotateX(radians(90));
    circle(0, 75, 50);

    
    
    popMatrix();
    
    popMatrix();
    

    
}
