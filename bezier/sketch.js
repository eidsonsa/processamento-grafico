var action;
var curvas = []
var qtdCurvas = 0
var atual;
//Implementar pegar o indice atual direto do html
var index = 0

var pontosOn = true;
var curvasOn = true;
var poligonosOn = true;

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


function canvasMouseClicked() {
  if (action == 'curva'){
    curvas[qtdCurvas - 1].push([mouseX, mouseY]);
  }
  if (action == 'adicionar'){
      curvas[addButton].push([mouseX, mouseY]);
      action = ''
  }
  return false;
}

var addButton = -1;

function adicionarBotao(indice){
  action = 'adicionar';
  addButton = indice;
}
//Pegar o evaluationFactor do HTML
//var evaluationFactor = 1/(document.getElementById('evaluationFactor').value);
//log(evaluationFactor);
evaluationFactor = 0.001;

function keyPressed(){
if (action == 'curva'){
  document.getElementById('lista-curvas').innerHTML = '';
  for (var i = 0; i < curvas.length; i++){
    document.getElementById('lista-curvas').innerHTML += '<li>' + 'Curva '+ (i + 1) + ':' + (curvas[i].length) +
    '<button onClick="adicionarBotao(' + i + ')">adicionar ponto</button>' + '</li>';
  }
    action = '';
 }
}



function setup(){
  var canvas = createCanvas(700, 700);
  canvas.parent('sketch-div');
  canvas.mouseClicked(canvasMouseClicked);
  background(212, 219, 245);
}

function draw(){
  background(212, 219, 245);
  if (pontosOn && curvas.length > 0){
    for (var j = 0; j < curvas[index].length; j++){
      fill(0, 41, 250)
      stroke(0, 41, 250);
      ellipse(curvas[index][j][0], curvas[index][j][1], 10, 10);
    }
  }
  if (curvasOn && curvas.length > index && curvas[index].length > 1){
    fill(141, 7, 246);
    stroke(141, 7, 246);
    var currentPoint = curvas[index][0]
    var lastPoint = curvas[index][curvas[index].length-1];
    for (var factor = evaluationFactor; factor <= 1; factor += evaluationFactor){
      var nextPoint = deCasteljau(curvas[index],factor);
      line(currentPoint[0], currentPoint[1], nextPoint[0], nextPoint[1]);
      currentPoint = nextPoint;
    }
    line(currentPoint[0], currentPoint[1], lastPoint[0], lastPoint[1]);
  }
  if (poligonosOn && curvas.length > index && curvas[index].length > 1){
    for (var j = 1; j < curvas[index].length; j++){
      fill(255, 255, 5);
      stroke(255, 255, 5);
      line(curvas[index][j - 1][0], curvas[index][j - 1][1], curvas[index][j][0], curvas[index][j][1]);
    }
  }

}

function interpolation(startPoint, endPoint, factor){
  return [ (1 - factor)*startPoint[0] + factor*endPoint[0] , (1 - factor)*startPoint[1] + factor*endPoint[1] ];
}

function deCasteljau (stageControlPoints, factor){
  //console.log(stageControlPoints)
  if(stageControlPoints.length == 1){
    return stageControlPoints[0];
  }else {
    var nextStageControlPoints = [];
    for(cont = 0; cont < stageControlPoints.length -1;++cont){
      var subControlPoint = interpolation(stageControlPoints[cont], stageControlPoints[cont+1], factor);
      nextStageControlPoints.push(subControlPoint);
    }
     return deCasteljau(nextStageControlPoints, factor);
  }
}
