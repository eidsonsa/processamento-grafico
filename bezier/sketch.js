 
var action;
var curvas = []
var qtdCurvas = 0
var atual;
//Implementar pegar o indice atual direto do html
var index = 0
var indiceaadicionar = -1;
//var evaluationFactor = 0.001

var pontosOn = true;
var curvasOn = true;
var poligonosOn = true;

function ativarPonto(){
  pontosOn = !pontosOn;
}

function ativarCurva(){
  curvasOn = !curvasOn;
}

function ativarPoligono(){
  poligonosOn = !poligonosOn;
}

function chooseAction(act){

  if (act == 'criarcurva'){
    evaluationFactor = 1 / document.getElementById('evaluationFactor').value
    action = 'curva';
    curvas[qtdCurvas] = [];
    index = qtdCurvas;
    qtdCurvas++;
  }
  if(act == 'deletarcurva'){
    curvas.splice(index,1)
    if(index > 0){
      --index;
    }
    --qtdCurvas;
    action = 'remover';
  }
  if(act == 'deletarponto'){
    action = 'remover';
  }
  if(act == 'adicionarponto'){
    action = 'adicionar';
  }
}

var indicearemover = -1

function canvasMouseClicked() {
  if (action == 'curva'){
    curvas[qtdCurvas - 1].push([mouseX, mouseY]);
  }
  if (action == 'adicionar'){
    curvas[index].push([mouseX, mouseY]);
    action = 'curva'
  }
  if (action == 'remover'){
    var ponto = findControlPoint(curvas[index], [mouseX, mouseY]);
    if (ponto != null){
      curvas[index].splice(ponto, 1)
    }
    if (curvas[index].length == 0){
      curvas.splice(index, 1)
    }
  }
  return false;
}

function mouseDragged(){
  if(curvas.length > 0 && curvas[index].length > 0){
    var indexControlPoint = findControlPoint(curvas[index],[mouseX,mouseY]);
    if(indexControlPoint != null){
      curvas[index][indexControlPoint][0] = mouseX;
      curvas[index][indexControlPoint][1] = mouseY;
    }
  }
  action = 'grabPoint';
  return false;
} 

function findControlPoint(curve, point){
  for(cont = 0; cont < curve.length; ++cont){
    if(Math.sqrt(Math.pow((curve[cont][0] - point[0]),2) + Math.pow((curve[cont][1] - point[1]),2) <= 1000)){  //1000 é o quanto o mouse pode se distanciar do ponto
      return cont;
    }
  }
  return null;
}

function adicionarPonto(indice){
  action = 'adicionar';
  indiceaadicionar = indice;
}

function removerPonto(indice){
  indicearemover = indice
  action = 'remover'
}

function keyPressed(){
if (action == 'curva'){
  document.getElementById('lista-curvas').innerHTML = '';
  for (var i = 0; i < curvas.length; i++){
    document.getElementById('lista-curvas').innerHTML += '<li>' + 'Curva '+ (i + 1) + ':' + (curvas[i].length) +
    '<button onClick="adicionarPonto(' + i + ')">adicionar ponto</button>' + '<button onClick="removerPonto(' + i + ')"> remover ponto </button>' + '</li>';
  }
    action = '';
 }
}

function mudarIndice(direcao){
  if (direcao == 'diminuir'){
    if (index != 0 ){
      index--;
    }
  }
  if (direcao == 'aumentar'){
    if (index < curvas.length - 1){
      index++;
    }
  }
}


window.onload=function(){var evaluationFactorHTML = document.getElementById('evaluationFactor');

evaluationFactor.onchange = function(){
  evaluationFactor = 1 / evaluationFactorHTML.value 
    
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



function setup(){
  var canvas = createCanvas(700, 700);
  canvas.parent('sketch-div');
  canvas.mouseClicked(canvasMouseClicked);
  background(212, 219, 245);
}

function draw(){
  background(212, 219, 245);
  for(var i = 0; i < curvas.length; ++i){
    if (pontosOn && i < curvas.length){
      for (var j = 0; j < curvas[i].length; j++){
        fill(0, 41, 250)
        stroke(0, 41, 250);
        ellipse(curvas[i][j][0], curvas[i][j][1], 10, 10);
      }
    }
    if (curvasOn && i < curvas.length && curvas[i].length > 1){
      if(i == index){
        fill('red');
        stroke('red');
      }else{
        fill(141, 7, 246);
        stroke(141, 7, 246);
      }
      var currentPoint = curvas[i][0]
      var lastPoint = curvas[i][curvas[i].length-1];
      for (var factor = evaluationFactor; factor <= 1; factor += evaluationFactor){
        var nextPoint = deCasteljau(curvas[i],factor);
        line(currentPoint[0], currentPoint[1], nextPoint[0], nextPoint[1]);
        currentPoint = nextPoint;
      }
      line(currentPoint[0], currentPoint[1], lastPoint[0], lastPoint[1]);
    }
    if (poligonosOn && i < curvas.length && curvas[i].length > 1){
      for (var j = 1; j < curvas[i].length; j++){
        fill(255, 255, 5);
        stroke(255, 255, 5);
        line(curvas[i][j - 1][0], curvas[i][j - 1][1], curvas[i][j][0], curvas[i][j][1]);
      }
    }
  }
}

