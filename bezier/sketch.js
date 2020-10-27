var action;

function chooseAction(act){
  if (act == 'criarponto'){
    action = 'ponto'
  }
}

function setup(){
  var canvas = createCanvas(700, 700);
//  canvas.parent('sketch-div');
  background(220, 220, 220);
}

function draw(){

  if (mouseIsPressed == true && mouseButton == LEFT && action == 'ponto'){
    fill(0);
    ellipse(mouseX, mouseY, 10, 10);
    action = ''
  }
}
