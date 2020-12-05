PImage imgBaseKd;
PImage imgBaseN;
PImage imgBaseKs;
boolean mostrarDifusa = true;
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
  int[] camera = {width/2, height/2};
  print(new PVector (float((mouseX - camera[0])), float((mouseY - camera[1])), 1) + "\n") ;
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      int loc = j + i * width;

      PVector mouseCameraL = new PVector (float((mouseX - camera[0])/(camera[0]/2)), float((mouseY - camera[1])/(camera[1]/2)), 1).normalize();
      PVector pixelCameraV = new PVector(float((j - camera[0])/(camera[0]/2)), float((i - camera[1])/(camera[1]/2)), 1).normalize();
      
      
      PVector pixelNormal = new PVector (red(imgBaseN.pixels[loc])/255,green(imgBaseN.pixels[loc])/255,blue(imgBaseN.pixels[loc])/255);
      
      //
      PVector Kd;
      if(mostrarDifusa){
        Kd = new PVector(red(imgBaseKd.pixels[loc])/255,green(imgBaseKd.pixels[loc])/255,blue(imgBaseKd.pixels[loc])/255);
      }else{
        Kd = new PVector(0,0,0);
      }
      PVector Ks;
      if(mostrarEspecular){
        Ks = new PVector(red(imgBaseKs.pixels[loc])/255,green(imgBaseKs.pixels[loc])/255,blue(imgBaseKs.pixels[loc])/255);
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
  PVector difusa = PVector.mult(kd,(max(-1*pixelNormal.dot(mouseCameraL),0)));
  PVector especular = PVector.mult(ks,(pow(R.dot(pixelCameraV),9)));
  PVector cor = PVector.add(difusa, especular).normalize();
  return color(((cor.x)*(light.x))*255,((cor.y)*(light.y))*255,((cor.z)*(light.z))*255); //<>//
}
