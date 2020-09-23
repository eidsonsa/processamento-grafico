float xC;
float yC;
float xR;
float yR;
float diam;
float radious;
float velocity;
float teta;
int z;
int quadrante;

void setup(){
  size(800,600);
  background(153);
  teta = 0;
  velocity = PI/(frameRate*4);
  diam = 5;
  xR = 0;
  yR = 0;
  radious = 20;
  quadrante = -1;
}


void setupCoordinateSystem(){
  translate(width/2,height/2);
  stroke(153,204,50);
  line(0,-width,0,width);
  stroke(0,127,255);
  line(height,0,-height,0);
  scale(-1,1);
}

void createCircle(float x, float y, float diam){
  fill(165,42,42);
  noStroke();
  circle(x,y,diam);
}

void draw(){
  setupCoordinateSystem();
  xC =  xR + radious*cos(teta);
  yC = radious*sin(teta);
  createCircle(xC,yC,diam);
  if((yC >= 0.1 && quadrante == -1) || (yC <= 0 && quadrante == 1)){
    radious *= 2;
    xR = xC - radious;
    quadrante *= -1;
  }
  teta += velocity;
}
