PImage imgBase;
PImage imgNormal;
PImage imgEspecular;
boolean mostrarDifusa = true;
boolean mostrarEspecular = true;
float Ia = 0.5;
float n = 10;

void setup() {
  size(396, 600, P3D);
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
  
  image(imgBase, 0, 0);
  
  PVector posicaoLuz = new PVector(mouseX, mouseY, 0);
  
 // loadPixels();
  //imgBase.loadPixels();
  
  
  
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      
      int loc = j + i * width;
      
      loadPixels();
      imgBase.loadPixels();
      color Ka = pixels[loc];
      updatePixels();
      
      PVector normal = new PVector(width / 2, height / 2, 0);
      float componenteDifuso = max((normal.normalize()).dot(posicaoLuz.normalize()), 0);
      loadPixels();
      imgNormal.loadPixels();
      color Kd = pixels[loc];
      updatePixels();
      
      PVector R = posicaoLuz.sub((normal.mult((normal.normalize()).dot(posicaoLuz.normalize()))).mult(2));
      float componenteEspecular = max(0, normal.dot(R));
      loadPixels();
      imgEspecular.loadPixels();
      color Ks = pixels[loc];
      updatePixels();
      
      loadPixels();
      imgBase.loadPixels();
      pixels[loc] = max(256, int(Ia * Ka + componenteDifuso * Kd + componenteEspecular * Ks));
      updatePixels();
      
      
      
      
      
      
      
      
      //int loc = j + i * width;
      //pixels[loc] = color(0,0,0);
      
    }
  }
  
 // updatePixels();
  
  
}
