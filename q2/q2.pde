float xC1;
float yC1;
float xC2;
float yC2;
float diam;
float velocity;
float teta;
float alpha;
float dist1;
float dist2;

void setup(){
  size(800,600);
  teta = 0;
  alpha = 0;
  dist1 = 2;
  dist2 = 3;
  diam = 0.5;
  velocity = PI/(frameRate*4);
}

void setupCoordinateSystem(){
  background(0,0,255);
  translate(width/2,height/2);
  scale(20,20);
}
void createCircle(float x, float y, float diam){
  fill(255,255,255);
  noStroke();
  circle(x,y,diam);
}

void createLine(float x1, float y1, float x2, float y2){
  strokeWeight(0.2);
  stroke(0,0,0);
  line(x1,y1,x2,y2);
}

void draw(){
  setupCoordinateSystem();
  xC1 = dist1*sin(teta);
  yC1 = dist1*cos(teta);
  xC2 = xC1 + dist2*sin(alpha);
  yC2 = yC1 + dist2*cos(alpha);
  createCircle(0,0,diam);
  createCircle(xC1,yC1,diam);
  createCircle(xC2,yC2,diam);
  createLine(0,0,xC1,yC1);
  createLine(xC1,yC1,xC2,yC2);
  if(yC1 - yC2 >=0){
    alpha = 0;
    teta = 0;
  }
  alpha += velocity;
  teta += velocity/2;
}
