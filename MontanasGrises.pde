import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
float x,y;
float time;
float time2;
int num;
float nois_pass;
float[] pasoXn;
float[] xn;
//float xn;
  float tim;
  float radioSol =400;
  int posSol=width/2;
void setup() {
  size(1280, 720,P3D);
   x=0;
 y=100;
  time = 1;
  time2=1;
  num=6;
  nois_pass=0.0045;
  //xn=0;
  xn= new float[num];
  pasoXn=new float[num];
  for (int i = 0; i < num; i++) {
    xn[i]=0;
    pasoXn[i]=0.002 +0.002*i;
  }
  oscP5 = new OscP5(this,12000);
   myRemoteLocation = new NetAddress("127.0.0.1",12000);
}

void draw() {
  background(255,220,220,1);
  //cielo();
  sol();
  for (int x = 0; x <= width; x = x + 1) {
    for (int i = 0; i < num; i++) {
      strokeWeight(2);
      stroke(220 - 220/num * i,255);
      line(x, y + 50 * i + 300 * noise(x *nois_pass+xn[i],time*i), x, height);
      
    }
  }
   for (int i = 0; i < num; i++) {
    xn[i]+= pasoXn[i];
  }
  time = time + 0.0001; 
  
  //xn+=0.004;
}
void sol(){
  noStroke();
  for (int i = 0; i < num; i++) {
   fill(240,183-i*10,109,50);
    float r= radioSol+ noise(time2*5)*150+ i*40;
   ellipse(posSol,150,r,r);
  }
  
 time2 = time2 + 0.00021; 
}

void cielo(){
   color c1,c2;    
   int pasosDibujo=10000;    // Cuantos pasos hace en cada frame
    for(int i=0;i<pasosDibujo;i++){  
      // xoff+=pasoPerlin;
      //float r=noise(xoff)*tamMaxMezcla;      //Longitud de las lineas
      c1=  color(random(50,255),15);
      c2=  color(random(50,255),15);
      stroke(c1);
      float a=random(0,height/2);
      
      line(0, a, width, a);
       
      a=random(0,height/2);
      float a2=random(0,height/2);
      stroke(c2);
      line(0, a, width, a2);
   
    }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
   if (theOscMessage.checkAddrPattern("/posX")==true) {
    posSol=theOscMessage.get(0).intValue();
  }
  else{
    posSol=width/2;
  }
 
}
