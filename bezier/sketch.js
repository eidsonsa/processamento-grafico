 
//Valor Inicial de variaveis comuns
var action;
var curvas = []
var qtdCurvas = 0
var index = 0
var indiceaadicionar = -1;

//Variaveis de Valor Inicial das Check Boxes
var pontosOn = true;
var curvasOn = true;
var poligonosOn = true;

//Funções de Interação com as Check Boxes
function ativarPonto(){
  pontosOn = !pontosOn;
}

function ativarCurva(){
  curvasOn = !curvasOn;
}

function ativarPoligono(){
  poligonosOn = !poligonosOn;
}

//Controle de Ações
function chooseAction(act){
  if (act == 'criarcurva'){
    evaluationFactor = 1 / document.getElementById('evaluationFactor').value
    action = 'adicionar';
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

//Função de Interação com o Mouse 'Click'. Usamos para adicionar e remover pontos, a escolha de cada ação depende do do botão/action ativa.
function canvasMouseClicked() {
  if (action == 'adicionar'){
    curvas[index].push([mouseX, mouseY]);
  }
  if (action == 'remover'){
    var ponto = findControlPoint(curvas[index], [mouseX, mouseY]);
    if (ponto != null){
      curvas[index].splice(ponto, 1);
    }
    if (curvas[index].length == 0){
      curvas.splice(index, 1);
      if(index > 0){
        --index;
      }
    }
  }
  return false;
}

//Função de Interação com o Mouse 'Arrastar'. Usamos pra alterar os pontos de Controle da Reta Selecionada
function mouseDragged(){
  if(curvas.length > 0 && curvas[index].length > 0){
    var indexControlPoint = findControlPoint(curvas[index],[mouseX,mouseY]);
    if(indexControlPoint != null){
      curvas[index][indexControlPoint][0] = mouseX;
      curvas[index][indexControlPoint][1] = mouseY;
      action = 'grabPoint';
    }
  }
  return false;
} 

//Mudança entre as Curvas feita pelas setas no HTML
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

//Pegando o Fator de Avaliação do HTML
window.onload=function(){var evaluationFactorHTML = document.getElementById('evaluationFactor');
evaluationFactor.onchange = function(){
  evaluationFactor = 1 / evaluationFactorHTML.value 
    }
}

//Setup do Canvas
function setup(){
  var canvas = createCanvas(1200, 800);
  canvas.parent('sketch-div');
  canvas.mouseClicked(canvasMouseClicked);
  background(212, 219, 245);
}

function draw(){
  background(212, 219, 245);
  //Desenho dos Pontos de Controle
  for(var i = 0; i < curvas.length; ++i){
    if (pontosOn && i < curvas.length && curvas[i] != null){
      for (var j = 0; j < curvas[i].length; j++){
        fill(0, 41, 250)
        stroke(0, 41, 250);
        ellipse(curvas[i][j][0], curvas[i][j][1], 10, 10);
      }
    }
    //Desenho das Curvas
    if (curvasOn && i < curvas.length && curvas[i] != null && curvas[i].length > 1){
      if(i == index){
        fill(10, 23, 71);
        stroke(10, 23, 71);  //A Curva Atual é Sempre a azul-escura.
      }else{
        fill(141, 7, 246);
        stroke(141, 7, 246);
      }
      //Chamada do Algoritmo de DeCasteljau
      var currentPoint = curvas[i][0]
      var lastPoint = curvas[i][curvas[i].length-1];  //Ele não calcula o primeiro e o último ponto já que são triviais, foca só nos pontos internos.
      for (var factor = evaluationFactor; factor <= 1; factor += evaluationFactor){
        var nextPoint = deCasteljau(curvas[i],factor);
        line(currentPoint[0], currentPoint[1], nextPoint[0], nextPoint[1]);
        currentPoint = nextPoint;
      }
      line(currentPoint[0], currentPoint[1], lastPoint[0], lastPoint[1]);
    }
    //Desenho dos Poligonos de Controle
    if (poligonosOn && i < curvas.length && curvas[i] != null && curvas[i].length > 1){
      for (var j = 1; j < curvas[i].length; j++){
        fill(255, 255, 5);
        stroke(255, 255, 5);
        line(curvas[i][j - 1][0], curvas[i][j - 1][1], curvas[i][j][0], curvas[i][j][1]);
      }
    }
  }
}

//Algoritmo de DeCasteljau
function deCasteljau (stageControlPoints, factor){
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

//Função de Interpolação
function interpolation(startPoint, endPoint, factor){
  return [ (1 - factor)*startPoint[0] + factor*endPoint[0] , (1 - factor)*startPoint[1] + factor*endPoint[1] ];
}

//Função Usada para Arrastar os Pontos de Controle da Reta Selecionada
function findControlPoint(curve, point){
  for(cont = 0; cont < curve.length; ++cont){
    if(Math.sqrt(Math.pow((curve[cont][0] - point[0]),2) + Math.pow((curve[cont][1] - point[1]),2) <= 1000)){ 
      return cont;                                               //1000 é o fator de distanciamento do mouse
    }
  }
  return null;
}