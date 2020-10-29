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
//Definições Arbitrárias que futuramente devemos pegar do HTML:
//
var hideControlPoints = false;
var hideControlPolygonal = false;
var hideCurve = false;
var evaluationFactor = 0.001;

function keyPressed(){
if (action == 'curva'){
    curvas[atual].shift()
    for(factor = 0; factor <= 1; factor = factor + evaluationFactor){
      deCasteljau(curvas[atual],factor);
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

function draw(){}

function interpolation(startPoint, endPoint, factor){
  return [ (1 - factor)*startPoint[0] + factor*endPoint[0] , (1 - factor)*startPoint[1] + factor*endPoint[1] ];
}

function deCasteljau (stageControlPoints, factor){
  if(stageControlPoints.length == 1){
    fill(0);
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
