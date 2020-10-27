var action;
var curvas = []
var qtdCurvas = 0
var atual;

function chooseAction(act){

  if (act == 'criarcurva'){
    action = 'curva';
    curvas[qtdCurvas] = [];
    atual = qtdCurvas;
    qtdCurvas++;
  }
}

var pts = [];

function mouseClicked() {
  if (action == 'curva'){
    fill(0);
    ellipse(mouseX, mouseY, 10, 10);
    curvas[qtdCurvas - 1].push([mouseX, mouseY]);
  }
  return false;
}

function keyPressed(){
  if (action == 'curva'){
    for (var i=1; i < curvas[atual].length-1; ++i) {
      fill(0);
      line(curvas[atual][i][0], curvas[atual][i][1], curvas[atual][i+1][0], curvas[atual][i+1][1]);
    }
    document.getElementById('lista-curvas').innerHTML += '<li>' + 'Curva '+ (atual + 1) + ':' + (curvas[atual].length - 1) + '</li>';
    action = '';
  }
}


function setup(){
  var canvas = createCanvas(700, 700);
 canvas.parent('sketch-div');
  background(220, 220, 220);
}

function draw(){



}

