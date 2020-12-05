PImage imgBaseKd;
PImage imgBaseKa;
PImage imgBaseKs;
boolean mostrarDifusa = true;
boolean mostrarEspecular = true;
float Ia = 0.5;
float n = 10;

void setup() {
  size(396, 600, P3D);
  imgBaseKd = loadImage("/Texturas/char1_d.png");
  imgBaseKa = loadImage("/Texturas/char1_n.png");
  imgBaseKs = loadImage("/Texturas/char1_s.png");
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
      
      int loc = j + i * width;
      
      loadPixels();
      imgBaseKd.loadPixels();
      color Ka = pixels[loc];
      updatePixels();
      float componenteDifuso = max((normal.normalize()).dot(posicaoLuz.normalize()), 0);
      loadPixels();
      imgBaseKa.loadPixels();
      color Kd = pixels[loc];
      updatePixels();
      
      PVector R = posicaoLuz.sub((normal.mult((normal.normalize()).dot(posicaoLuz.normalize()))).mult(2));
      float componenteEspecular = max(0, normal.dot(R));
      loadPixels();
      imgBaseKs.loadPixels();
      color Ks = pixels[loc];
      updatePixels();
      
      loadPixels();
      imgBaseKd.loadPixels();
      pixels[loc] = max(256, int(Ia * Ka + componenteDifuso * Kd + componenteEspecular * Ks));
      updatePixels();
      //-----------------------------------------------------------------------------------------------------
      int[] camera = {width / 2, height / 2};
      PVector mouseCameraL = new PVector (mouseX - camera[0], mouseY - camera[1],0).normalize();
      PVector pixelNormal = new PVector (j,i,1).normalize();
      PVector pixelCameraV = new PVector(j - camera[0], i - camera[1], 0).normalize();
      //
      loadPixels();
      pixels[loc] = phong(
        color(255,255,255)/255,
        imgBaseKd.pixels[loc]/255,
        imgBaseKa.pixels[loc]/255,
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
  color difusa = kd*pixelNormal.dot(mouseCameraL);
  float ambiente = 0.5;
  float especular = R.dot(pixelCameraV);
  color phong = ka*ambiente + kd*difusa + ks*especular;
  return (ka*ambiente + kd*difusa + ks*especular);
}
