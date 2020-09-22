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
  posicao = new PVector(circleX, circleY);
  velocidade = new PVector(0.2, 0.2);
  gravidade = new PVector(0, 0);

}

void draw() {
  // clear out old frames
    background(220, 220, 220);
    fill(256, 0, 0);
    rect(0, 200, 600, 400);
    
    posicao.add(velocidade);
    velocidade.add(gravidade);
    
    if ((posicao.x > width) || (posicao.x < 200)){
      velocidade.x += -1;
    }
    
    if (posicao.y > height){
      posicao.y = height;
    }
    
    fill(0, 0, 250);
    ellipse(posicao.x, posicao.y, 60, 60);
    
}
