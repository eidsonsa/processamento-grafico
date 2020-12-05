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
  //background(0);
  
  //float dirX = (mouseX / float(width) - 0.5) * 2;
  //float dirY = (mouseY / float(height) - 0.5) * 2;
  
  //directionalLight(204, 204, 204, -dirX, -dirY, 0);
  
  //translate(width/2 - 100, height/2, 0);
  
  //sphere(80);
  
  image(imgBaseKd, 0, 0);
  
  PVector posicaoLuz = new PVector(mouseX, mouseY, 0);
  
 // loadPixels();
  //imgBase.loadPixels();
  
  
  
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){
      //-----------------------------------------------------------------------------------------------------
      int loc = j + i * width;
      int[] camera = {width / 2, height / 2};
      PVector mouseCameraL = new PVector (mouseX - camera[0], mouseY - camera[1],0).normalize();
      PVector pixelNormal = new PVector (red(imgBaseKd.pixels[loc]),green(imgBaseKd.pixels[loc]),blue(imgBaseKd.pixels[loc])).normalize();
      PVector pixelCameraV = new PVector(j - camera[0], i - camera[1], 0).normalize();
      //
      loadPixels();
      pixels[loc] = phong(
        color(255,255,255)/255,
        imgBaseKd.pixels[loc]/255,
        imgBaseN.pixels[loc]/255,
        imgBaseKs.pixels[loc]/255,
        mouseCameraL,
        pixelNormal, 
        calculateR(pixelNormal, mouseCameraL),
        pixelCameraV
       ); 
      updatePixels();      
      //int loc = j + i * width;
      //pixels[loc] = color(0,0,0);
      
    }
  }
  // R = L - 2*(dot(N, L))*N posicaoLuz.sub((normal.mult((normal.normalize()).dot(posicaoLuz.normalize()))).mult(2));

  
 // updatePixels();
}
public PVector calculateR (PVector N, PVector L){
  return L.sub(N.mult(max(N.dot(L),0)*2)).normalize();
}
public color phong(color light, color kd, color ka, color ks, PVector mouseCameraL, PVector pixelNormal, PVector R, PVector pixelCameraV){
  float difusa = kd*pixelNormal.dot(mouseCameraL);
  float ambiente = ka*light;
  float especular = ks*pow(R.dot(pixelCameraV),9);
  return int(255*(ambiente + difusa + especular)); //<>//
}
