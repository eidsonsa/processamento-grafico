PImage imgBaseKd;
PImage imgBaseN;
PImage imgBaseKs;
boolean mostrarDifusa = false;
boolean mostrarEspecular = true;
float Ia = 0.5;
float n = 10;

void setup() {
  size(410, 736, P3D);
  imgBaseKd = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char2_d.png");
  //imgBaseKd = loadImage("/Texturas/char2_d.png");
  imgBaseN = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char2_n.png");
  //imgBaseN = loadImage("/Texturas/char2_n.png");
  imgBaseKs = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char2_s.png");
  //imgBaseKs = loadImage("/Texturas/char2_s.png");
}

// http://www.cs.toronto.edu/~jacobson/phong-demo/

void draw() {
  float[] camera = {width/2, height/2,-1};
  //PVector a = new PVector (red(imgBaseN.pixels[600]) / 255.0, green(imgBaseN.pixels[600]) / 255.0, blue(imgBaseN.pixels[600]) / 255.0).normalize();
  //PVector b = new PVector ((mouseX - camera[0])/(camera[0]), ((mouseY - camera[1])/(camera[1])), 1).normalize();
  //print(a + " " + b + " " + max(a.dot(b), 0) + "\n");
  PVector mouseCameraL = new PVector ((mouseX - camera[0])/(camera[0]), ((mouseY - camera[1])/(camera[1])), 1); 
  //print(mouseCameraL + " " + mouseCameraL.normalize() + "\n");
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      int loc = j + i * width;

      PVector pixelCameraV = new PVector(((i - camera[1])/(camera[1])),((j - camera[0])/(camera[0])), 1);
  
      PVector pixelNormal = new PVector (red(imgBaseN.pixels[loc]) / 255.0, green(imgBaseN.pixels[loc]) / 255.0, blue(imgBaseN.pixels[loc]) / 255.0);
      //print(pixelNormal + " ");
      //
      PVector Kd;
      if(mostrarDifusa){
        Kd = new PVector(red(imgBaseKd.pixels[loc]) / 255.0, green(imgBaseKd.pixels[loc]) / 255.0, blue(imgBaseKd.pixels[loc]) / 255.0);
      }else{
        Kd = new PVector(0,0,0);
      }
      PVector Ks;
      if(mostrarEspecular){
        Ks = new PVector(red(imgBaseKs.pixels[loc]) / 255.0,green(imgBaseKs.pixels[loc]) / 255.0, blue(imgBaseKs.pixels[loc]) / 255.0);
      }else{
        Ks = new PVector(0,0,0);
      }
      //
      loadPixels();
      pixels[loc] = phong(
        new PVector(255 / 255, 255 / 255, 255 / 255),
        Kd,
        Ks,
        mouseCameraL,
        pixelNormal, 
        calculateR(pixelNormal, PVector.mult(mouseCameraL,-1)),
        pixelCameraV
       ); 
      updatePixels();      
    }
  }
}
public PVector calculateR (PVector N, PVector L){
  float cosseno = PVector.dot(N, L)*2;
  PVector subtracao = PVector.mult(N, cosseno);
  PVector R = PVector.sub(L, subtracao);
  return R.normalize();
}
//
public color phong(PVector light, PVector kd, PVector ks, PVector mouseCameraL, PVector pixelNormal, PVector R, PVector pixelCameraV){
  //print(R);
  float produtoInterno = max(PVector.dot(pixelNormal,mouseCameraL), 0);
  PVector difusa = PVector.mult(kd, produtoInterno);
  float componenteEspecular = max(PVector.dot(pixelCameraV, R), 0);
  PVector especular = PVector.mult(ks,(pow(componenteEspecular,9)));
  PVector cor = PVector.add(PVector.div(difusa,2), PVector.div(especular,2));
  //print((cor.x * 255) + " " + (cor.y * 255) + " " + (cor.z * 255) + "\n");
  return color(((cor.x)*(light.x))*255,((cor.y)*(light.y))*255,((cor.z)*(light.z))*255); //<>//
}
