class Ser01 {
  PApplet p5;
  PVector posicao;
  float id;
  //ellipse (shape to lathe)
  int pts;
  float angle;
  float radius;
  // lathe segments (segmentos de la figura)
  int segments; //segmentos com a quantidade de pontos antes definida
  float latheAngle;
  float latheRadius;
  //vertices da figura
  Point3D vertices[], vertices2[];
  // for shaded or wireframe rendering
  boolean isWireFrame = true;
  boolean isHelix;
  float helixOffset;
  boolean rotateMouse;
  PVector valoresRotacion;

 Ser01(PApplet _p5, PVector _posicao, int _id){
   p5 = _p5;
   posicao = _posicao;
   id = _id;
   
  pts = 40;
  angle = 0;
  radius = 150.0;//40.0;
  // lathe segments (segmentos de la figura)
  segments = 10;//60; //segmentos com a quantidade de pontos antes definida
  latheAngle = 0;
  latheRadius = 155;//50.0;// 100.0;
  //vertices da figura
  isHelix = true;
  helixOffset = 5.0;
  rotateMouse = false;
  valoresRotacion = new PVector(0,0,0);
 } 
 
 public void SetNovosValores() {
  isWireFrame = true;
  isHelix = true;
  rotateMouse = false;
  pts =  40;
  segments = 60;
  latheRadius = 100.0;
  radius = 40.0;
 }
 public void UpdateValores() {
  isWireFrame = true;
  isHelix = true;
  rotateMouse = false;
  pts =  50  + (int) ( 8 * cos (millis()*.0001) );
  segments = 50;//(int) ( abs (50 * cos (millis()*.001) ) );
  latheRadius =  20.0;//5; //100.0;
  radius = 50.0 + ( 2 * cos (millis()*.0001) ) ;//10.0;//40.0;
 }
 public void UpdateValores01() {
  isWireFrame = true;
  isHelix = true;
  rotateMouse = false;
  pts =  20 + (int) ((10 * cos (millis()*.001) ) );
  segments = 10;//(int) ( abs (50 * cos (millis()*.001) ) );
  latheRadius =  10.0;//5; //100.0;
  radius = 350.0;// * noise ((id*50)) ; //+ ( 20.0 * cos (millis() * .001) ) ;//10.0;//40.0;
 }
 
 public void desenhaSer() {
   p5.pushStyle(); 
   p5.pushMatrix();
   p5.translate(posicao.x, posicao.y, posicao.z);
   UpdateValores01();
   
   if (isWireFrame){
     p5.stroke(255);
     p5.noFill();
   }
     else {
       p5.noStroke();
       p5.fill(200);
   }
   
   rotacionDeSer();
   
   UpdateValores();
   manifestacaoSer02();
// UpdateValores01
// manifestacaoSer01();

   p5.popMatrix();
   p5.popStyle();
 }
 
  public void rotacionDeSer(){
   //rotaçāo para visualizaçāo
  if (rotateMouse) {
    if (mousePressed) {
    valoresRotacion.x = ( map(mouseX, 0, width, 0, TWO_PI) );
    valoresRotacion.y = ( map(mouseY, 0, height, 0, TWO_PI) );
    valoresRotacion.z = 0 ;  
    }
    
  } else {
    valoresRotacion.x = (frameCount*PI/150);
    valoresRotacion.y = (frameCount*PI/170);
    valoresRotacion.z = (frameCount*PI/90);
  }
   p5.rotateX(valoresRotacion.x);
   p5.rotateY(valoresRotacion.y);
   p5.rotateZ(valoresRotacion.z); 
  }
 public void manifestacaoSer01(){
   vertices = new Point3D[pts+1];
   vertices2 = new Point3D[pts+1];
  latheAngle = 0;
  int colorV = 60;//(int) ( 255 / (segments) );
  for(int j=0; j<=pts; j++){ //loop por cada ponto para dar a forma
    vertices[j] = new Point3D();
    vertices2[j] = new Point3D();
    float val = cos(id+millis() * .001) ;
    vertices[j].x = latheRadius + sin(radians(angle))* (radius * val) ;
    if (isHelix){
      vertices[j].z = cos(radians(angle))*(radius * val)-(helixOffset * segments)/2;
    } else {
      vertices[j].z = cos(radians(angle))*(radius * val);
    }
    angle+=360.0/pts;
  }
  
  float v = radius/segments;
  for(int i=0; i<=segments; i++){
    p5.stroke(255);// (255 - (colorV*i % 255) ) * cos(i+millis()*.01) );
    for(int j=0; j<=pts; j++){
      //os vertices centrais
      PVector prev = new PVector();
      if (i>0){ //tiene el valor de la vuelta anterior
        prev = new PVector(vertices2[j].x , vertices2[j].y , vertices2[j].z);
 //       vertex(vertices2[j].x , vertices2[j].y , vertices2[j].z );
        
      }
      
      vertices2[j].x = cos(radians(latheAngle))* vertices[j].x ;
      vertices2[j].y = sin(radians(latheAngle))* vertices[j].x ;
      vertices2[j].z = vertices[j].z;
      // optional helix offset
      if (isHelix){
        vertices[j].z+=helixOffset;
      }
      p5.stroke(255);
      p5.strokeWeight(1);
      p5.point(vertices2[j].x, vertices2[j].y, vertices2[j].z);
      if (i>0){ //tiene el valor de la vuelta anterior
        p5.strokeWeight(.5);
 //       line(prev.x, prev.y, prev.z, vertices2[j].x , vertices2[j].y , vertices2[j].z);
        p5.strokeWeight(1);
      }
      
//    vertex(vertices2[j].x, vertices2[j].y, vertices2[j].z);
   }
    // create extra rotation for helix
    if (isHelix){
    latheAngle+=720.0/segments;
    } else {
    latheAngle+=360.0/segments;
    }
//  endShape();
  }  
}
public void manifestacaoSer02(){
  vertices = new Point3D[pts+1];
  vertices2 = new Point3D[pts+1];
  latheAngle = 0;
  for(int j=0; j<=pts; j++){ //loop por cada ponto para dar a forma
    vertices[j] = new Point3D();
    vertices2[j] = new Point3D();
    float val =  1;// cos(millis() * .001) ;
    vertices[j].x = latheRadius + sin(radians(angle))* (radius * val) ;
    if (isHelix){
      vertices[j].z = cos(radians(angle))*(radius * val)-(helixOffset * segments)/2;
    } else {
      vertices[j].z = cos(radians(angle))*(radius * val);
    }
    angle+=360.0/pts;
  }
  
  float v = radius/segments;
  for(int i=0; i<=segments; i++){
    float val =  v*i;//cos( i + millis() * .001) ;
    for(int j=0; j<=pts; j++){
      vertices[j].x = latheRadius + sin(radians(angle))* (radius * val) ;
      if (isHelix){
        vertices[j].z = cos(radians(angle))*(radius * val)-(helixOffset * segments)/2;
      } else {
        vertices[j].z = cos(radians(angle))*(radius * val);
      }
      angle+=360.0/pts;
    }
    p5.beginShape(QUAD_STRIP);
    p5.stroke(255);// (255 - (colorV*i % 255) ) * cos(i+millis()*.01) );
    for(int j=0; j<=pts; j++){
      //os vertices centrais
      if (i>0){ //tiene el valor de la vuelta anterior
        p5.vertex(vertices2[j].x , vertices2[j].y , vertices2[j].z );
      }
      
      vertices2[j].x = cos(radians(latheAngle))* vertices[j].x ;
      vertices2[j].y = sin(radians(latheAngle))* vertices[j].x ;
      vertices2[j].z = vertices[j].z;
      // optional helix offset
      if (isHelix){
        vertices[j].z+=helixOffset;
      }
    p5.vertex(vertices2[j].x, vertices2[j].y, vertices2[j].z);
   }
    // create extra rotation for helix
    if (isHelix){
    latheAngle+=720.0/segments;
    } else {
    latheAngle+=360.0/segments;
    }
    p5.endShape();
  }  
}
}
