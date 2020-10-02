float radius = 30;
PVector posicao;
PVector velocidade;
PVector gravidade;


void setup() {
  size(1200, 600);
  frameRate(60);
  posicao = new PVector(radius, height - radius);
  velocidade = new PVector(9.5, -9.5);

}

// 2s - 60fps - 120 frames
// 1140 pixels em 120 frames - 9.5 pixels por frame 


// ponto (0,0) é o superior esquerdo
// ponto(0, 300) é onde a bolinha começa
// ponto(x, 100) é o ponto maximo que a bolinha pode kikar

void draw() {
  // clear out old frames
    background(220, 220, 220);
    fill(256, 0, 0);
    rect(0, 300, 1200, 600);
    
    posicao.add(velocidade);
    
    if ((posicao.x > width - radius) || (posicao.x < radius)){
      velocidade.x *= -1;
    }
    
    if (posicao.y < 100){
      posicao.y = 100;
      velocidade.y *= -1;
    }
    
    if (posicao.y > 300 - radius){
      posicao.y = 300 - radius;
      if (velocidade.y < 0){
        velocidade.y = 10.5; // como está descendo, velocidade + gravidade
      }
      else{
        velocidade.y = -9.5;
      }
    }
    
    fill(0, 0, 250);
    ellipse(posicao.x, posicao.y, 60, 60);
    
}
