PImage imgBaseKd;
PImage imgBaseN;
PImage imgBaseKs;
boolean mostrarDifusa = false;
boolean mostrarEspecular = true;
float Ia = 0.5;
float n = 10;

void setup() {
  size(396, 600, P3D);
  //imgBaseKd = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char1_d.png");
  imgBaseKd = loadImage("/Texturas/char1_d.png");
  //imgBaseN = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char1_n.png");
  imgBaseN = loadImage("/Texturas/char1_n.png");
  //imgBaseKs = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char1_s.png");
  imgBaseKs = loadImage("/Texturas/char1_s.png");
}

// http://www.cs.toronto.edu/~jacobson/phong-demo/

void draw() {
  float[] camera = {width/2, height/2};
  //print(new PVector ((mouseX - camera[0])/(camera[0]/2), ((mouseY - camera[1])/(camera[1]/2)), 1).normalize() + " " + "\n") ;
  
  
  //mouseCameraL = PVector.mult(mouseCameraL, 2);
 // mouseCameraL = new PVector(mouseCameraL.x - 1, mouseCameraL.y - 1, mouseCameraL.z - 1); 
  //print(mouseCameraL + "\n");
  
  //PVector pixelCameraV = new PVector(((390 - camera[0])/(camera[0])), ((245 - camera[1])/(camera[1])), 1).normalize();
  //print(pixelCameraV + "\n");
  
  //print( new PVector (red(imgBaseN.pixels[600]) / 255.0, green(imgBaseN.pixels[600]) / 255.0, blue(imgBaseN.pixels[600]) / 255.0) + "\n");
  
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      int loc = j + i * width;

      PVector mouseCameraL = new PVector ((mouseX - camera[0])/(camera[0]), ((mouseY - camera[1])/(camera[1])), 1).normalize(); 
      PVector pixelCameraV = new PVector(((j - camera[0])/(camera[0])), ((i - camera[1])/(camera[1])), 1).normalize();
  
      
      //PVector pixelCameraV = new PVector(((j - camera[0])/(camera[0]/2)), ((i - camera[1])/(camera[1]/2)), 1);
      //pixelCameraV = PVector.mult(pixelCameraV, 2);
      //pixelCameraV = new PVector(pixelCameraV.x - 1, pixelCameraV.y - 1, pixelCameraV.z - 1);
      
      
      PVector pixelNormal = new PVector (red(imgBaseN.pixels[loc]) / 255.0, green(imgBaseN.pixels[loc]) / 255.0, blue(imgBaseN.pixels[loc]) / 255.0);
      
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
        new PVector(1, 1, 1),
        Kd,
        Ks,
        mouseCameraL,
        pixelNormal, 
        calculateR(pixelNormal, mouseCameraL),
        pixelCameraV
       ); 
      updatePixels();      
    }
  }
}
public PVector calculateR (PVector N, PVector L){
  float cosseno = N.dot(L) * 2;
  PVector subtracao = N.mult(cosseno);
  PVector R = L.sub(subtracao);
  R = R.normalize();
  return R;
}
//
public color phong(PVector light, PVector kd, PVector ks, PVector mouseCameraL, PVector pixelNormal, PVector R, PVector pixelCameraV){
  float produtoInterno = max(pixelNormal.dot(mouseCameraL), 0);
  PVector difusa = PVector.mult(kd, produtoInterno).normalize();
  float componenteEspecular = max(pixelCameraV.dot(R), 0);
  PVector especular = PVector.mult(ks,(pow(componenteEspecular,9))).normalize();
  PVector cor = PVector.add(difusa, especular);
  print((cor.x * 255) + " " + (cor.y * 255) + " " + (cor.z * 255) + "\n");
  return color(((cor.x)*(light.x))*255,((cor.y)*(light.y))*255,((cor.z)*(light.z))*255); //<>//
}
