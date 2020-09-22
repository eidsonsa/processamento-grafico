// state
float radius = 30;
float circleX = radius;
float circleY = 200;
PVector posicao;
PVector velocidade;
PVector gravidade;

// frameRate = 10 fps
// 4s = 40 frames -> 20 ida 20 volta
// 500 uc / 20 frames = 25 uc/frame velocidade vertical 

void setup() {
  size(600, 400);
  posicao = new PVector(30, 170);
  velocidade = new PVector(2, -4);
  gravidade = new PVector(0, 0);

}

// ponto (0,0) é o superior esquerdo
// ponto(0, 200) é onde a bolinha começa
// ponto(x, 150) é o ponto maximo que a bolinha pode kikar

void draw() {
  // clear out old frames
    background(220, 220, 220);
    fill(256, 0, 0);
    rect(0, 200, 600, 400);
    
    posicao.add(velocidade);
    velocidade.add(gravidade);
    
    if ((posicao.x > width - radius) || (posicao.x < radius)){
      velocidade.x *= -1;
    }
    
    if (posicao.y < 50){
      posicao.y = 50;
      velocidade.y *= -1;
    }
    
    if (posicao.y > 170){
      posicao.y = 170;
      velocidade.y *= -1;
    }
    
    fill(0, 0, 250);
    ellipse(posicao.x, posicao.y, 60, 60);
    
}

//void draw() {
//  background(0);
  
//  // Add velocity to the location.
//  posicao.add(velocidade);
//  // Add gravity to velocity
//  velocidade.add(gravidade);
  
//  // Bounce off edges
//  if ((posicao.x > width) || (posicao.x < 0)) {
//    velocidade.x = velocidade.x * -1;
//  }
//  if (posicao.y > height) {
//    // We're reducing velocity ever so slightly 
//    // when it hits the bottom of the window
//    velocidade.y = velocidade.y * -0.95; 
//    posicao.y = height;
//  }

//  // Display circle at location vector
//  stroke(255);
//  strokeWeight(2);
//  fill(127);
//  ellipse(posicao.x,posicao.y,48,48);
//}
