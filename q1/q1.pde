float radius = 30;
PVector posicao;
PVector velocidade;
PVector gravidade;


void setup() {
  size(1000, 600);
  posicao = new PVector(30, 270);
  velocidade = new PVector(8, -10);
  gravidade = new PVector(0, 0.5);

}

// ponto (0,0) é o superior esquerdo
// ponto(0, 300) é onde a bolinha começa
// ponto(x, 100) é o ponto maximo que a bolinha pode kikar

void draw() {
  // clear out old frames
    background(220, 220, 220);
    fill(256, 0, 0);
    rect(0, 300, 1000, 600);
    
    posicao.add(velocidade);
    velocidade.add(gravidade);
    
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
        velocidade.y = 10.5;
      }
      else{
        velocidade.y = -10;
      }
    }
    
    fill(0, 0, 250);
    ellipse(posicao.x, posicao.y, 60, 60);
    
}
