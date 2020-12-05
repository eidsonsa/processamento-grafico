PImage imgBaseKd;
PImage imgBaseN;
PImage imgBaseKs;
boolean mostrarDifusa = true;
boolean mostrarEspecular = true;
float Ia = 0.5;
float n = 10;

void setup() {
  size(396, 600, P3D);
  imgBaseKd = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char1_d.png");
  imgBaseN = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char1_n.png");
  imgBaseKs = loadImage("/home/cesar/Code/pgboyz/p3/Texturas/char1_s.png");
}

// http://www.cs.toronto.edu/~jacobson/phong-demo/

void draw() {
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      int loc = j + i * width;
      int[] camera = {width / 2, height / 2};
      PVector mouseCameraL = new PVector (mouseX - camera[0], mouseY - camera[1],0).normalize();
      PVector pixelNormal = new PVector (red(imgBaseN.pixels[loc]),green(imgBaseN.pixels[loc]),blue(imgBaseN.pixels[loc])).normalize();
      PVector pixelCameraV = new PVector(j - camera[0], i - camera[1], 0).normalize();
      //
      PVector Kd;
      if(mostrarDifusa){
        Kd = new PVector(red(imgBaseKd.pixels[loc]),green(imgBaseKd.pixels[loc]),blue(imgBaseKd.pixels[loc])).normalize();
      }else{
        Kd = new PVector(0,0,0);
      }
      PVector Ks;
      if(mostrarEspecular){
        Ks = new PVector(red(imgBaseKs.pixels[loc]),green(imgBaseKs.pixels[loc]),blue(imgBaseKs.pixels[loc])).normalize();
      }else{
        Ks = new PVector(0,0,0);
      }
      //
      loadPixels();
      pixels[loc] = phong(
        new PVector(255,255,255).normalize(),
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
  return L.sub(N.mult(max(N.dot(L),0)*2)).normalize();
}
//
public color phong(PVector light, PVector kd, PVector ks, PVector mouseCameraL, PVector pixelNormal, PVector R, PVector pixelCameraV){
  PVector difusa = kd.mult(max(-1*pixelNormal.dot(mouseCameraL),0));
  PVector especular = ks.mult(pow(R.dot(pixelCameraV),9));
  PVector cor = difusa.add(especular).normalize();
  return color(((cor.x)*(light.x))*255,((cor.y)*(light.y))*255,((cor.z)*(light.z))*255); //<>//
}
