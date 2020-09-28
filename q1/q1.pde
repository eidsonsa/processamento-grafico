float radius = 30;
PVector posicao;
PVector velocidade;
PVector gravidade;


void setup() {
  size(1000, 600);
  frameRate(25);
  posicao = new PVector(radius, height - radius);
  velocidade = new PVector(10, -10);

}

// 4s - 25fps - 100 frames
// 1000 pixels em 100 frames - 10 pixels por frame 

// ponto (0,0) é o superior esquerdo
// ponto(0, 300) é onde a bolinha começa
// ponto(x, 100) é o ponto maximo que a bolinha pode kikar

void draw() {
  // clear out old frames
    background(220, 220, 220);
    fill(256, 0, 0);
    rect(0, 300, 1000, 600);
    
    posicao.add(velocidade);
    
    if ((posicao.x > width - radius) || (posicao.x < radius)){
      velocidade.x *= -1;
    }
    
    if (posicao.y < 100){
      posicao.y = 100;
      velocidade.y = -10.5;
    }
    
    if (posicao.y > height - radius){
      posicao.y = height - radius;
      velocidade.y = -10;
    }
    
    fill(0, 0, 250);
    ellipse(posicao.x, posicao.y, 60, 60);
    
}
