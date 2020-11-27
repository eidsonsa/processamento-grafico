PImage imgBase;
PImage imgNormal;
PImage imgEspecular;
boolean mostrarDifusa = true;
boolean mostrarEspecular = true;
float Ka = 0.5; 
float Kd = 0.5;
float Ks = 0.5;

void setup() {
  size(600, 600, P3D);
  imgBase = loadImage("/Texturas/char1_d.png");
  imgNormal = loadImage("/Texturas/char1_n.png");
  imgEspecular = loadImage("/Texturas/char1_s.png");
}

// http://www.cs.toronto.edu/~jacobson/phong-demo/

void draw() {
  //background(0);
  
  //float dirX = (mouseX / float(width) - 0.5) * 2;
  //float dirY = (mouseY / float(height) - 0.5) * 2;
  
  //directionalLight(204, 204, 204, -dirX, -dirY, 0);
  
  //translate(width/2 - 100, height/2, 0);
  
  //sphere(80);
  
  PVector posicaoLuz = new PVector(mouseX, mouseY, 0);
  
  loadPixels();
  imgBase.loadPixels();
  
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      
      PVector interpolacaoNormal = new PVector(0,0,0);
      PVector N = interpolacaoNormal.normalize();
      PVector posicaoPixel = new PVector(j, i, 0);
      PVector L = posicaoLuz.sub(posicaoPixel);
      
      float lambertian = max(N.dot(L), 0);
      if (lambertian > 0){
        PVector R = -L.reflect(
      }
      
      
      int loc = j + i * width;
      pixels[loc] = color(0,0,0);
      
    }
  }
  
  updatePixels();
  
  
}
