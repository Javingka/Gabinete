/**
* Programa para execuñ{ao do Gabinete de Alice. Que considera uma projeção com 4 projetores e duas kinects para a interação
* nessa versão a leitura da kinect não esta implementada, por que ela sera implementada quando essa programação fique dividida em dois computadores
* um dele com a leitura das kinects, constrol dos cenários visíveis e previsualização no modelo virtual
* o outro com o código de visualização
*
* O código aqui é composto por 4 PApplet principais:
* PApplet default  Projeção de animações na tela de proporciones ajustadas a 2 projetores (que funcionara no computador 1)
* PApplet 2  Projeção de animações na tela de proporciones ajustadas a 2 projetores (que funcionara no computador 1)
* PApplet 3 Previsualização do modelo virtual  (que funcionara no computador 2)
* PApplet 4 Control dos cenários visíveis  (que funcionara no computador 2)
*
* by Javier Cruz
*/ 

import controlP5.*;  
import java.awt.Frame;
import java.awt.event.KeyEvent;
import java.text.*;

// public ControlP5 control;
//Segunda Terceira quarta janela de projeçāo
PFrame2 frame2;
PFrame3 frame3;
PFrame4 frame4;
PApplet2 PApp2;
PApplet3 PApp3;
PApplet4 PApp4;

//index da câmara ativa na imagem
int actualViewType_0 = 8; 

//ESFERA, A GEOMETRIA BASE DO MODELO.
EsferaBase esferaB;

boolean verTelas;
boolean modoPresentacao; //tem um modo de presentacao e um outro de edicao
public void init(){
  println("frame: processing e PApplet: processing / primeira janela de projecao. frame e PApplet por default");
  // to make a frame not displayable, you can
  // use frame.removeNotify()

  frame.removeNotify();
  frame.setUndecorated(true);

  // addNotify, here i am not sure if you have 
  // to add notify again.  
  frame.addNotify();
  super.init();
}
 void setup() {
    size(int (( 1366 * 2 ) * .4 )  , int ( 768 * .4) , P3D);//1366, 768, P3D);
    println("inicio setup() PApplet base");
    
    frame.setLocation((int)(width*.25), 0 );
    
    esferaB = new EsferaBase(this, "PApp1");
    
   //setting a segunda janela com o respectivo sketch
    frame2 = new PFrame2(); 
    frame3 = new PFrame3();
    frame4 = new PFrame4();  
    //frame4 vai depois de esferaB porque precisamos conhecer a quantidade de cenarios para previsualizar eles
    
    rectMode(CENTER);
    textSize(50);
    textAlign(CENTER, CENTER);
    verTelas = modoPresentacao = false;
    println("fim setup() PApplet base");
}
  
  void draw() {
//    println("draw PApp 1");
    background(0);

//    ambientLight(200, 200, 200);
//    PApp2.ambientLight(200, 200, 200);
    
  if (PApp4.getPreview()) {
        esferaB.setAng_X_Puntero( PApp4.getAngXPuntero() );
        esferaB.setAng_Y_Puntero( PApp4.getAngYPuntero() );
        esferaB.setAng_Z_Puntero( PApp4.getAngZPuntero() );
        esferaB.setAng_X_Camara( PApp4.getAngXCamara() );
        esferaB.setAng_Y_Camara( PApp4.getAngYCamara() );
        esferaB.setAng_Z_Camara( PApp4.getAngZCamara() );    
        esferaB.setDistanciaFoco( PApp4.getDistanciaFoco() );
        
        verTelas = PApp4.getVerTelas();
      }
      
     if (verTelas) {
        camera();
        desenhaTela();
        println("rolando ver telas PApp1");
    } else {
       esferaB.desenhaModelo(actualViewType_0); //desenha a esfera e todo o que em ela estiver visível
    }
    
    if (!modoPresentacao) {
      PApp3.redraw();
    }
    
  }
  public void desenhaTela() {
    int w = width / 2;
    int h = height;

    pushStyle();
    rectMode(CENTER);
    stroke(255,0,0);
    strokeWeight(3);
    fill(255,200);
    rect(width*.25f, h/2, w, h );
    rect(width*.75f, h/2, w, h );
    fill(0);
    textSize(50);
    text("1", width*.25f, h/2);
    text("2", width*.75f, h/2);
    popStyle();
  }
  public void setDistanciaFocoCamara(float d){
     esferaB.setDistanciaFoco(d); 
  }
  public void ligaCenarioNome(String nome){
    esferaB.ligaCenario(nome);
  }
  public void desligaCenarioNome(String nome){
    esferaB.desligaCenario(nome);
  }
  public PVector getAngulosCenario(String nome) {
    return esferaB.getAngulosCenario(nome);
  }
  
// ============================================================
// SEGUNDA JANELA Projecao
// ============================================================
  public class PFrame2 extends Frame {
    
    public PFrame2() {
      println("frame: PFrame2 e PApplet: PApplet2 / segunda janela de projecao");
      setUndecorated(true);
      int widthTela = int (( 1366 * 2 ) * .4 );
      int heightTela = int ( 768 * .4);
      setBounds(0,0, widthTela  , heightTela);//1200, 768);
      setLocation((int)(width*.25), heightTela +10);
      PApp2 = new PApplet2();
      add(PApp2);
      PApp2.init();
      show();
    }
}

public class PApplet2 extends PApplet {
  public boolean pronto = false;
  EsferaBase esferaB2;
  int actualViewType_1 = 2;
  boolean verTelas;
  
  public void setup() {
      size( int (( 1366 * 2 ) * .4 ) , int ( 768 * .4) , P3D);
      println("inicio setup() PApp2");
      esferaB2 = new EsferaBase(this, "PApp2");
      println("fim setup() PApp2");
      pronto = true;
      verTelas = false;
    }

    public void draw() {
//      println("draw PApp 2");
      background(0);
    
//      stroke(255);noFill();rect(0,0,width, height);
      if (PApp4.getPreview()) {
        esferaB2.setAng_X_Puntero( PApp4.getAngXPuntero() );
        esferaB2.setAng_Y_Puntero( PApp4.getAngYPuntero() );
        esferaB2.setAng_Z_Puntero( PApp4.getAngZPuntero() );
        esferaB2.setAng_X_Camara( PApp4.getAngXCamara() );
        esferaB2.setAng_Y_Camara( PApp4.getAngYCamara() - PI ); // -PI gera que a imagem seja de frente a aquelada projecao 1
        esferaB2.setAng_Z_Camara( PApp4.getAngZCamara() );    
        esferaB2.setDistanciaFoco( PApp4.getDistanciaFoco() );
        
        verTelas = PApp4.getVerTelas();
      }
      
      if (verTelas) {
        camera();
        desenhaTela();
        println("rolando ver telas PApp2");
      } else {
        esferaB2.desenhaModelo(actualViewType_1);
      }
      
    }
   public void desenhaTela() {
    int w = width / 2;
    int h = height;

    pushStyle();
    rectMode(CENTER);
    stroke(255,0,0);
    strokeWeight(3);
    fill(255,200);
    rect(width*.25f, h/2, w, h );
    rect(width*.75f, h/2, w, h );
    fill(0);
    textSize(50);
    text("3", width*.25f, h/2);
    text("4", width*.75f, h/2);
    popStyle();
  }
  public void setDistanciaFocoCamara(float d){
     esferaB2.setDistanciaFoco(d); 
  }
    public void ligaCenarioNome(String nome){
    esferaB2.ligaCenario(nome);
  }
  public void desligaCenarioNome(String nome){
    esferaB2.desligaCenario(nome);
  }
} 

// ============================================================
// TERCEIRA JANELA | Modelo de navegacao de referenca
// ============================================================
 public class PFrame3 extends Frame {
    public PFrame3() {
      println("frame: PFrame3 e PApplet: PApplet3 / terceira janela com o preview 3D");
      setBounds(0,0, 400, 400);//1200, 768);
      setLocation(0,500);
//      setUndecorated(true);
      PApp3 = new PApplet3();
      add(PApp3);
      PApp3.init();
      show();
    }
}

public class PApplet3 extends PApplet {
  NavegacaoCam3D gerenciaCam;
  public int indexCamara;

    public void setup() {
      size(400, 400, P3D);
      println("inicio setup() PApp3");
//      if (gerenciaCam == null) gerenciaCam = new NavegacaoCam3D(this);
      println("fim setup() PApp3");
      noLoop();
    }

    public void draw() {
        background(0);
        if (PApp4.getPreview()) {
          gerenciaCam.setAng_X_Puntero( PApp4.getAngXPuntero() );
          gerenciaCam.setAng_Y_Puntero( PApp4.getAngYPuntero() );
          gerenciaCam.setAng_Z_Puntero( PApp4.getAngZPuntero() );
          gerenciaCam.setAng_X_Camara( PApp4.getAngXCamara() );
          gerenciaCam.setAng_Y_Camara( PApp4.getAngYCamara() );
          gerenciaCam.setAng_Z_Camara( PApp4.getAngZCamara() );    
          gerenciaCam.setDistanciaFoco( PApp4.getDistanciaFoco() );
        }
        gerenciaCam.aplicaCamara( PApp4.getCamaraIn() ); //indexCamara);
        gerenciaCam.desenhaModelo();
    }
    public void setIndexCamara(int _index){
      indexCamara = _index;
    }
    public boolean agregaUmCenario (PMatrix3D m, String _name, PVector angulosPos) {
      if (gerenciaCam == null) gerenciaCam = new NavegacaoCam3D(this);
      boolean resp = false;
      print("agrega um cenario em gerenciaCam   / ");
      gerenciaCam.agregaUmCenario(m, _name, angulosPos);
      resp = true;
      return resp;
    }
    public int getIndexCamara(){
     return  indexCamara;
    }
    public void generalZoomIn () {
      if (gerenciaCam != null)  gerenciaCam.zoomIn(); 
    }
    public void generalZoomOut () {
       if (gerenciaCam != null) gerenciaCam.zoomOut(); 
    }
    public void ligaCenarioNome(String nome) {
      gerenciaCam.ligaCenario(nome);
    }
    public void desligaCenarioNome(String nome) {
      gerenciaCam.desligaCenario(nome);
    }
} 
// ============================================================
// QUARTA JANELA | Controles de manipulacao de visualizacao
// ============================================================
 public class PFrame4 extends Frame {
    public PFrame4() {
      println("frame: PFrame4 e PApplet: PApplet4 / quarta janela com os controles");
//      setUndecorated(true);
      setBounds(0,0, 1000  , 220);//1200, 768);
      setLocation(10, 350);
      PApp4 = new PApplet4();
      add(PApp4);
      PApp4.init();
      show();
    }
}

public class PApplet4 extends PApplet {
  
//Variaveis ajustaveis
  int indexCamara; //variavel sem utilzar, para exluir tem que mudar alguns métodos
  float ang_X_Puntero, ang_Y_Puntero, ang_Z_Puntero;
  float ang_X_Camara, ang_Y_Camara, ang_Z_Camara;
  float zoom; //zoom da visualizacao previa

  boolean event = false; //boolean para souber cada novo evento nos controles
  boolean preview = false; //Liga o control com as projeções
  boolean viewScreens = false; //para visualizar os limites da tela de cada projetor
  boolean camara_In; //Se a visualizacao esta em estado de 3ra pessoa ou 1era
  
  boolean anteriorPreview; //boolean para evaluar los cambios entre ocultar e mostrar janela
  boolean cenariosCarregados = false; //para carrrgar uma vez os cenarios
//  Textfield XangPosText, YangPosText, ZangPosText;
//  Textfield XangCamText, YangCamText, ZangCamText;
  
  String Xp,Yp,Zp,Xc,Yc,Zc; //nomes dos TextField dos angulos do puntero e da camara
  ArrayList <String> listaCenarios; //uma lista com os nomes dos cenarios existentes
  ControlTimer timerSequenca;
  String tempoCero;
//  ArrayList <DropdownList> listaReproducao;//uma lista com os cenarios ordenados
  ControlP5 control;
  
  public void setup() {
    size(1000 , 220);
    println("inicio setup() PApp4");   
    listaCenarios = new ArrayList <String>();
//    listaReproducao = new ArrayList <DropdownList>();
    control = new ControlP5(this);
    makePreviewControls();
    carregaCenarios();
//    frame3.setVisible(false); //tira a janela de preview do inicio para que seja ativada
    println("fim setup() PApp4");
  }

  public void draw() {
//    println("draw PApp 4");
    background(0);
    if (cenariosCarregados) imprimeTempo();
  }
  void imprimeTempo(){
    if (control.get(Toggle.class,"PLAY").getState() ) {
      String tempoa = timerSequenca.toString(); //carrega o String que mostra quando nao esta ativado o PLAY
      String nomeAtual = "TEMPO:     " + tempoa;
      control.get(Textlabel.class,"label_tempo").setText(nomeAtual);
    }
  }
  void makePreviewControls() {
    Xp = Yp = Zp = Xc = Yc = Zc = ""; 
  
  int yt = 80;
  control.addTextfield("Xp",10, yt += 10 ,30,9).align(0,0,10,5);//this is where you type the words
  control.addTextfield("Yp",10, yt += 10 ,30,9).align(0,0,10,5);//this is where you type the words
  control.addTextfield("Zp",10, yt += 10 ,30,9).align(0,0,10,5);//this is where you type the words
  control.addTextfield("Xc",10, yt += 10 ,30,9).align(0,0,10,5);
  control.addTextfield("Yc",10, yt += 10 ,30,9).align(0,0,10,5);
  control.addTextfield("Zc",10, yt += 10 ,30,9).align(0,0,10,5);
  
  //java.lang.String theName, float theMin,float theMax,  float theDefaultValue,  int theX,int theY,  int theW,int theH
  int y = 80;
  control.addSlider("ang_X_Puntero",  .0,   TWO_PI*1.1,   .0,   45,   y += 10,   500, 9).setLabel("Giro puntero X").setColorForeground(color(255,200,120));//.getCaptionLabel().toUpperCase(true).align(230,0);
  control.addSlider("ang_Y_Puntero",  .0,   TWO_PI*1.1,   .0,   45,   y += 10,   500, 9).setLabel("Giro puntero Y").setColorForeground(color(255,200,120));
  control.addSlider("ang_Z_Puntero",  .0,   TWO_PI*1.1,   .0,   45,   y += 10,   500, 9).setLabel("Giro puntero Z").setColorForeground(color(255,200,120));
  control.addSlider("ang_X_Camara",   .0,   TWO_PI*1.1,   .0,   45,   y += 10,   500, 9).setLabel("Giro camara X").setColorForeground(color(0, 255, 0));
  control.addSlider("ang_Y_Camara",   .0,   TWO_PI*1.1,   .0,   45,   y += 10,   500, 9).setLabel("Giro camara Y").setColorForeground(color(0, 255, 0));
  control.addSlider("ang_Z_Camara",   .0,   TWO_PI*1.1,   .0,   45,   y += 10,   500, 9).setLabel("Giro camara Z").setColorForeground(color(0, 255, 0));
  control.addSlider("zoom",   .0,   1.0,   .5,   10,   y += 10,   230, 9).setColorForeground(color(0, 0, 255));
  control.addToggle("preview", false, 10, y = 25, 9, 9).setLabel("      preview").getCaptionLabel().align(LEFT, CENTER);
  control.addToggle("camara_In", false, 10, y += 11, 9, 9).setLabel("      camara_In").getCaptionLabel().align(LEFT, CENTER);
  control.addBang("zoom_in").setPosition(10, y += 11).setSize(10, 10).setColorForeground(color(255, 0, 255)).setLabel("      zoom_in").getCaptionLabel().align(LEFT, CENTER);
  control.addBang("zoom_out").setPosition(10, y += 11).setSize(10, 10).setColorForeground(color(255, 0, 255)).setLabel("      zoom_out").getCaptionLabel().align(LEFT, CENTER);
  control.addToggle("viewScreens", false, 10, y += 11, 9, 9).setLabel("      ver telas").getCaptionLabel().align(LEFT, CENTER);
  }
  public boolean isCenariosCarregados() {
   return cenariosCarregados; 
  }
  public void carregaCenarios() { //é chamado desde o PApplet inicial e o segundo (PApp2), até que os cenarios sejam carregados, até que: cenariosCarregados = true;
     int cenariosTotal = esferaB.getCantCenarios();
     println("Cenarios carregados na clase esfera: " + cenariosTotal);
     int y = 11; int contador = 0 ;
      
      for (int i = 0 ; i < cenariosTotal ; i++ ) {
        PMatrix3D matrixTem = esferaB.getMatrixCenarioIndex(i);
        String nomeTem = esferaB.getNameCenarioIndex(i);
        PVector angs = esferaB.getAngulosCenario(nomeTem);
        if (PApp3.agregaUmCenario(matrixTem, nomeTem, angs)) {
          listaCenarios.add(nomeTem);
          contador++; 
          println("...criando control do cenario... nome: "+nomeTem );
          control.addToggle(nomeTem, false, width*.75, y += 11, 9, 9).setLabel(nomeTem).getCaptionLabel().align(LEFT,CENTER).style().marginLeft = 15; //move to the right;//align(22, -5);
          String ativador = "ver" + nomeTem;
          control.addBang(ativador).setPosition(width*.82, y).setSize(10, 10).setColorForeground(color(255, 0, 255)).setLabelVisible(false);
        }
      } 
      if (contador == cenariosTotal) { //Quando todos os cenarios estever criados
        control.addTextlabel("labelCenario").setText("CENARIOS      ir").setPosition(width*.76,10).setColorValue(0xffffffff); //desenhamos o Texto
        settingTimerControl(cenariosTotal);
        cenariosCarregados = true; 
      }
  }
  void settingTimerControl(int cenariosTotal) {
    timerSequenca = new ControlTimer();
    timerSequenca.setSpeedOfTime(1);
    tempoCero = timerSequenca.toString(); //carrega o String que mostra quando nao esta ativado o PLAY
    tempoCero = "TEMPO: " + tempoCero;
    control.addTextlabel("label_tracks").setText("SEQUENCA DE ATIVACAO DE CENARIOS").setPosition(100,30).setColorValue(0xffffffff);
    control.addTextlabel("label_tempo").setText(tempoCero).setPosition(300,30).setColorValue(0xffffffff);
    
    control.addToggle("PLAY", false, 128, 44, 15, 15).setLabel("PLAY        ").getCaptionLabel().align(RIGHT, CENTER);
    println("===================CARREGANDO LISTA DE TRACKS DA SEQUENCA===================");
    for (int i = 0 ; i < cenariosTotal ; i++ ) {
      String track = "track" + i;
      control.addDropdownList(track).setPosition(145+(100*(i)), 60).setSize(98,98).setBackgroundColor(color(190)).setItemHeight(20).setBarHeight(15);//.captionLabel().set(nom);
      print ("Criando " + track + ": ");
      for (int j=0 ; j < listaCenarios.size() ; j++) {
        print(" cenario " + j + " /");
        control.get(DropdownList.class,track).addItem(listaCenarios.get(j), j);
      }
      println();
    }
    println("===================CENARIOS E LISTA DE TRACKS CARREGADOS===================");
  }
  void controlEvent(ControlEvent theEvent) {
    
//    event = true;
    
    if (theEvent.isGroup()) { // Escolha dos TRACKS
//      println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
    } else if (theEvent.isController()) {
//      println("Evento detectado: " + theEvent.getController().getName() + " id: " + theEvent.getController().getId() );
      
      if ( theEvent.getController().getName().equals("viewScreens") ) {
        
      }
      
      if ( theEvent.getController().getName().equals("preview") ) {
        if ( anteriorPreview != preview) {
         control.get(Slider.class,"zoom").update();
         frame3.setVisible(preview);
        }
        anteriorPreview = preview;
      }
      
      
      if ( theEvent.getController().getName().equals("zoom") ) { //Se o control mexido for zoom, o dado é enviado para as classes EsferaBase do PApplet base e do PApp2
         setDistanciaFocoCamara(zoom);
         PApp2.setDistanciaFocoCamara(zoom);
      }
      
      //Ligar e desligar cenários
      if (listaCenarios.size() > 0 ) {
       for ( String n : listaCenarios) { //percorrido por todos os cenarios
         if ( theEvent.getController().getName().equals(n) ) { //evalua se algum deles tem relacao com o evento acontecendo
           if (control.get(Toggle.class,n).getState()) { //Se o botao (toggle) é presionado vamos ligar os cenarios
              ligaCenarioNome(n);
              PApp2.ligaCenarioNome(n);
              PApp3.ligaCenarioNome(n);
      //        println("ligaCenarioNome: " + n);
           } else { //Se o botao (toggle) é false vamos desligar os cenarios
              desligaCenarioNome(n);
              PApp2.desligaCenarioNome(n);
              PApp3.desligaCenarioNome(n);
           }
         }
       } 
       
       for ( String n : listaCenarios) { //percorrido por todos os cenarios
         String ativador = "ver" + n;
         if ( theEvent.getController().getName().equals(ativador) ) {
           PVector novaPos = getAngulosCenario(n); //getAngulosCenario() é do PApplet principal, pega os dados da clase EsferaBase
           control.getController("ang_X_Puntero").setValue(TWO_PI-novaPos.x); //TWO-PI permite cambiar o sentido de giro. ControlP2, troca o valor de novaPos.x, a resta neutraliza a mudanza
           control.getController("ang_Y_Puntero").setValue(TWO_PI-novaPos.y);
           control.getController("ang_Z_Puntero").setValue(TWO_PI-novaPos.z);
           control.getController("ang_X_Puntero").update();
           control.getController("ang_Y_Puntero").update();
           control.getController("ang_Z_Puntero").update();
         }
       }
      } else if ( theEvent.getController().getName().equals("PLAY") ) {
        timerSequenca.reset();
        String tempoa = timerSequenca.toString(); //carrega o String que mostra quando nao esta ativado o PLAY
        tempoCero = "TEMPO:     " + tempoa;
        control.get(Textlabel.class,"label_tempo").setText(tempoCero);
      } else if ( theEvent.getController().getName().equals("zoom_in") ) {
        PApp3.generalZoomOut();
      } else if ( theEvent.getController().getName().equals("zoom_out") ) {
        PApp3.generalZoomIn();
      } else if ( theEvent.getController().getName().equals("ang_X_Puntero") ) {
        double number = ang_X_Puntero;
        DecimalFormat numberFormat = new DecimalFormat("#.00");
        String ang = numberFormat.format(number);
        control.get(Textfield.class,"Xp").setText(ang);
      } else if ( theEvent.getController().getName().equals("ang_Y_Puntero") ) {
        double number = ang_Y_Puntero;
        DecimalFormat numberFormat = new DecimalFormat("#.00");
        String ang = numberFormat.format(number);
        control.get(Textfield.class,"Yp").setText(ang);
      } else if ( theEvent.getController().getName().equals("ang_Z_Puntero") ) {
        double number = ang_Z_Puntero;
        DecimalFormat numberFormat = new DecimalFormat("#.00");
        String ang = numberFormat.format(number);
        control.get(Textfield.class,"Zp").setText(ang);
      } else if ( theEvent.getController().getName().equals("ang_X_Camara") ) {
        double number = ang_X_Camara;
        DecimalFormat numberFormat = new DecimalFormat("#.00");
        String ang = numberFormat.format(number);
        control.get(Textfield.class,"Xc").setText(ang);
      } else if ( theEvent.getController().getName().equals("ang_Y_Camara") ) {
        double number = ang_Y_Camara;
        DecimalFormat numberFormat = new DecimalFormat("#.00");
        String ang = numberFormat.format(number);
        control.get(Textfield.class,"Yc").setText(ang);
      } else if ( theEvent.getController().getName().equals("ang_Z_Camara") ) {
        double number = ang_Z_Camara;
        DecimalFormat numberFormat = new DecimalFormat("#.00");
        String ang = numberFormat.format(number);
        control.get(Textfield.class,"Zc").setText(ang);
      } 
    }
  }
  public void Xp(String theText) {
     float val = parseFloat(theText); //numberFormat.format(number);
     control.get(Slider.class,"ang_X_Puntero").setValue(val);
     control.get(Slider.class,"ang_X_Puntero").update();
     control.get(Textfield.class,"Xp").setText(theText);
  }
  public void Yp(String theText) {
     float val = parseFloat(theText); //numberFormat.format(number);
     control.get(Slider.class,"ang_Y_Puntero").setValue(val);
     control.get(Slider.class,"ang_Y_Puntero").update();
  }
  public void Zp(String theText) {
     float val = parseFloat(theText); //numberFormat.format(number);
     control.get(Slider.class,"ang_Z_Puntero").setValue(val);
     control.get(Slider.class,"ang_Z_Puntero").update();
  }
  public void Xc(String theText) {
     float val = parseFloat(theText); //numberFormat.format(number);
     control.get(Slider.class,"ang_X_Camara").setValue(val);
     control.get(Slider.class,"ang_X_Camara").update();
  }
  public void Yc(String theText) {
     float val = parseFloat(theText); //numberFormat.format(number);
     control.get(Slider.class,"ang_Y_Camara").setValue(val);
     control.get(Slider.class,"ang_Y_Camara").update();
  }
  public void Zc(String theText) {
     float val = parseFloat(theText); //numberFormat.format(number);
     control.get(Slider.class,"ang_Z_Camara").setValue(val);
     control.get(Slider.class,"ang_Z_Camara").update();
  }
  boolean temEvento(){
    if (event) {
      event = false;
      return true;
    }
    return event; 
   }
  public boolean getVerTelas() {
    return   viewScreens;
  }
  public boolean getPreview(){
    return preview;
  }
  public float getAngXPuntero(){
    return ang_X_Puntero;
  }
  public float getAngYPuntero(){
    return ang_Y_Puntero;
  }
  public float getAngZPuntero(){
    return ang_Z_Puntero;
  }
  public float getAngXCamara(){
    return ang_X_Camara;
  }
  public float getAngYCamara(){
    return ang_Y_Camara;
  }
  public float getAngZCamara(){
    return ang_Z_Camara;
  }
  public float getDistanciaFoco() {
    return zoom;
  }
  public int getCamaraIn(){
    int r = 0;
    if (camara_In) r = 1;
    return r; 
  }
} 

// ============================================================
// INTERACOES | Controles de teclado e mouse
// ============================================================


   public void keyPressed(){
  //os valores que definem a quantidade de variaçāo no movimento da esfera
    float valY = TWO_PI * .0006; //height * 0.00005;
    float valX = TWO_PI * .0006; //width * 0.000005;
    float valZ = TWO_PI * .0006; //height * 0.000005;
    
    if (key == CODED) {
      //os valores tem que ficar numa escada para usar como angulo 
      
      //movimento da esfera
    if (keyCode == UP) {    //troca angulo X da posiçāo da esfera
      esferaB.setDesloques(       valX , 0, 0 );
      PApp2.esferaB2.setDesloques( valX , 0, 0 );
    } else if (keyCode == DOWN) { //troca angulo X da posiçāo da esfera
      esferaB.setDesloques(       -valX , 0, 0 );
      PApp2.esferaB2.setDesloques( -valX , 0, 0 );
    } else if (keyCode == LEFT) { //troca angulo Y da posiçāo da esfera
      esferaB.setDesloques(        0 , valY, 0 );  
      PApp2.esferaB2.setDesloques(  0 , valY , 0 );
    } else if (keyCode == RIGHT) { //troca angulo Y da posiçāo da esfera
      esferaB.setDesloques(        0 , -valY , 0 );  
      PApp2.esferaB2.setDesloques(  0 , -valY , 0 );  
    }
  }  else if (key == 'k') { //troca angulo Z da posiçāo da esfera
      esferaB.setDesloques(        0 , 0 , valZ  );
      PApp2.esferaB2.setDesloques(  0 , 0 , valZ );
    } 
    else if (key == 'l') { //troca angulo Z da posiçāo da esfera
      esferaB.setDesloques(        0 , 0 , -valZ );
      PApp2.esferaB2.setDesloques(  0 , 0 , -valZ );
    } else if (key == 'm'){ //muda o estado da animaçāo dos pássaros
      esferaB.mousePress();
      PApp2.esferaB2.mousePress();
    }
    else {
      PApp2.actualViewType_1 = actualViewType_0;
      if ((int) key == 56) actualViewType_0 = 8;
      if ((int) key == 50) actualViewType_0 = 2;
      if ((int) key == 52) actualViewType_0 = 4;
      if ((int) key == 54) actualViewType_0 = 6;
//      println("actualViewType_0: " +actualViewType_0);
    }
    //atualiza os dados dos angulos da esfera para mostrar na tela
    PVector angulosAtuais = esferaB.getAnglulosDePos();
    
  }
  void mousePressed() {
    esferaB.mousePress();
    PApp2.esferaB2.mousePress();
  }

