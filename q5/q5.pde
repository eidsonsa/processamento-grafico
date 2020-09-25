void setup() {
  size(700, 700, P3D);
  ellipseMode(CENTER);
  rectMode(CENTER);
  
}

void draw() {

    background(256, 256, 256);
    translate(width/2, height/2, 0);
    
    // fazer eixo Y
    stroke(0, 0, 256);
    line(0, -350, 0, 350);
    
    // fazer eixo X
    stroke(256, 0, 0);
    line(-350, 0, 350, 0);
       
       
    // desenhar circunferencia maior
    pushMatrix();
    
      rotateX(radians(60));
      translate(100, -100, 0); 
      stroke(0, 0, 0);
      rect(0,0, 200, 200);
      stroke(0, 0, 0);
      ellipse(0, 0, 200, 200);
      stroke(0, 0, 0);
      ellipse(0, 0, 3, 3);
    
      // fazer animacao do circulo menor
      pushMatrix();
      
        rotateZ(radians(frameCount * 1.5 % 360));
        translate(0, -100);
        
        // desenhar circulo menor
        pushMatrix();
        
          rotateX(radians(-90));
          translate(0, -25, 0);
          ellipse(0, 0, 50, 50);
          
          // desenhar ponto vermelho
          pushMatrix();
          
            rotateZ(radians(frameCount * 1.5  % 360));
            stroke(256,0,0);
            ellipse(0, -25, 4, 4);
          
          popMatrix();
          
        
        popMatrix();
         
      
      popMatrix();
    
    
    popMatrix();

}
