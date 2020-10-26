function setup(){
  var canvas = createCanvas(200, 200);
  canvas.parent('sketch-div');
  background(32);
}

function draw(){
  fill(255);
  ellipse(mouseX, mouseY, 25, 25);
}