var action;

function chooseAction(act){

  if (act == 'criarcurva'){
    action = 'curva';
  }
}

var pts = [];


function setup(){
  var canvas = createCanvas(700, 700);
 canvas.parent('sketch-div');
  background(220, 220, 220);
}

function draw(){


  if (mouseIsPressed == true && mouseButton == LEFT && action == 'curva'){
    fill(0);
    ellipse(mouseX, mouseY, 10, 10);
    pts.push([mouseX, mouseY]);
  }

  if (keyIsPressed == true && keyCode == ENTER && action == 'curva'){
    for (var i=0; i < pts.length-1; ++i) {
      fill(0);
      line(pts[i][0], pts[i][1], pts[i+1][0], pts[i+1][1]);
    }
  }
}
