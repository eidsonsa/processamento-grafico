void setup() {
  size(700, 700, P3D);
  ellipseMode(CENTER);
  
}

void draw() {

    background(256, 256, 256);
    
    // fazer eixo Y
    stroke(0, 0, 256);
    line(350, 0, 350, 350);
       
       
    //fazer eixo X rotacionada em 60   
    pushMatrix();
    translate(350, 350, 0); 
  
    rotateX(radians(60));
    stroke(256, 0, 0);
    line(0, 0, 350, 0);
    
    //stroke(0, 256, 0);
    ////rotateZ(radians(-90));
    //rotateY(radians(-45));
    //rotateX(radians(-45));
    //line(0, 0, 350, 0);
    
    // fazer o circulo, o quadrado circunscrito e o ponto no meio
    stroke(0, 0, 0);
    rect(0, -200, 200, 200);
    stroke(0, 0, 0);
    ellipse(100, -100, 200, 200);
    stroke(0, 0, 0);
    ellipse(100, -100, 2, 2);
    
    
    // fazer o circulo pequeno perpendicular
    pushMatrix();
    translate(100, -100, -25);
    rotateX(radians(-90));
    stroke(0, 0, 0);
    ellipse(0, -100, 50, 50);
    
    
    ////translate(100, -100, 0);
    //rotateY(radians(frameCount * 1.5 % 360));
    ////rotateZ(radians(frameCount * 1.5 % 360));
    ////rotateX(radians(-30));


    
    popMatrix();
    popMatrix();
    

    
}
