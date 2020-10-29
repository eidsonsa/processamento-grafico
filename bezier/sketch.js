var action;
var curvas = []
var qtdCurvas = 0
var atual;

var pontosOn = false;
var curvasOn = false;
var poligonosOn = false;

function chooseAction(act){

  if (act == 'criarcurva'){
    action = 'curva';
    curvas[qtdCurvas] = [];
    atual = qtdCurvas;
    qtdCurvas++;
  }
}

function ativarPonto(){
  pontosOn = !pontosOn;
}

function ativarCurva(){
  curvasOn = !curvasOn;
}

function ativarPoligono(){
  poligonosOn = !poligonosOn;
}

var pts = [];

clickFalso = true;

function mouseClicked() {
  if (action == 'curva'){
    curvas[qtdCurvas - 1].push([mouseX, mouseY]);
  }
  if (action == 'adicionar'){
    if (!clickFalso){
      curvas[index].push([mouseX, mouseY]);
      action = ''
    }
    clickFalso = false;
  }
  if (action == ''){
    clickFalso = true;
  }
  return false;
}

var index = -1;

function adicionarBotao(indice){
  action = 'adicionar';
  index = indice;
  console.log(index)
}

var evaluationFactor = 0.001;

function keyPressed(){
if (action == 'curva'){
    curvas[atual].shift()
    document.getElementById('lista-curvas').innerHTML += '<li>' + 'Curva '+ (atual + 1) + ':' + (curvas[atual].length) +
     '<button onClick="adicionarBotao(atual)">adicionar ponto</button>' + atual + '</li>';
    action = '';
 }
}



function setup(){
  var canvas = createCanvas(700, 700);
  canvas.parent('sketch-div');
  background(212, 219, 245);
}

function draw(){
  background(212, 219, 245);
  if (pontosOn){
    for (var i = 0; i < curvas.length; i++){
      for (var j = 0; j < curvas[i].length; j++){
        fill(0, 41, 250)
        stroke(0, 41, 250);
        ellipse(curvas[i][j][0], curvas[i][j][1], 10, 10);
      }
    }

  }
  if (curvasOn){
    for (var i = 0; i < curvas.length; i++){
      for (var factor = 0; factor <= 1; factor = factor + evaluationFactor){
        deCasteljau(curvas[i], factor);
      }
    }
  }
  if (poligonosOn){
    for (var i = 0; i < curvas.length; i++){
      for (var j = 1; j < curvas[i].length; j++){
        fill(255, 255, 5);
        stroke(255, 255, 5);
        line(curvas[i][j - 1][0], curvas[i][j - 1][1], curvas[i][j][0], curvas[i][j][1]);
      }
    }

  }

}

function interpolation(startPoint, endPoint, factor){
  return [ (1 - factor)*startPoint[0] + factor*endPoint[0] , (1 - factor)*startPoint[1] + factor*endPoint[1] ];
}

function deCasteljau (stageControlPoints, factor){
  if(stageControlPoints.length == 1){
    fill(141, 7, 246);
    stroke(141, 7, 246);
    ellipse(stageControlPoints[0][0],stageControlPoints[0][1],3,3);
  }else {
    var nextStageControlPoints = [];
    for(cont = 0; cont < stageControlPoints.length -1;++cont){
      var subControlPoint = interpolation(stageControlPoints[cont], stageControlPoints[cont+1], factor);
      nextStageControlPoints.push(subControlPoint);
    }
    deCasteljau(nextStageControlPoints, factor);
  }
}
