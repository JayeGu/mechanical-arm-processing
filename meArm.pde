import processing.serial.*;
Serial myPort;
float x, y;
float angle1 = 0.0;
float angle2 = 0.0;
float segLength = 80;
float segLength2 = 80;
float OA2 = segLength*segLength;
float AB2 = segLength2*segLength2;
float OB,OB2;
void setup() {
  size(500, 500);
  strokeWeight(20);
  stroke(255, 160);
  
  //String portName = Serial.list()[0];
  //myPort = new Serial(this, portName, 9600);
  background(255);
  x = width*0.5;
  y = height*0.5;
}

void draw() {
  if((pow(mouseX-250,2)+pow(mouseY-250,2)<=pow(segLength2+segLength,2))&&(pow(mouseX-250,2)+pow(mouseY-250,2)>=pow(segLength2-segLength,2))){
    ellipse(250,250,(segLength2+segLength+5)*2,(segLength2+segLength+5)*2);
    fill(0);
    
    translate(x, y); //总坐标转换到中间
    float mx = mouseX-250;  //鼠标坐标转换到中间点
    float my = 250-mouseY;
    OB = sqrt(pow(mx,2)+pow(my,2));
    OB2 = OB*OB;
    
    float JAOX = atan(my/mx)+acos((OA2+OB*OB-AB2)/(2*segLength*OB));
    float JBAC = acos((OA2+AB2-OB2)/(2*segLength*segLength2))+PI; //此处算出来是钝角的补角，所以加180度
    
    println("X:",mx,"Y:",my,"角1:",JAOX*180/PI,"角2:",(JBAC-PI)*180/PI);
    if(mx>0)
    {
      pushMatrix();
      segment(0, 0, -JAOX,segLength); 
      segment(segLength, 0, -JBAC,segLength2);
      popMatrix();
    }
    else
    {
      pushMatrix();
      segment(0, 0, -JAOX+PI,segLength); 
      segment(segLength, 0, -JBAC,segLength2);
      popMatrix();
    }
  }
}
//void serialEvent(Serial thisPort)
//{
//  String st = thisPort.readString();
//  println(st);
//}
void segment(float x, float y, float a,float len) {
  translate(x, y);
  rotate(a);
  line(0, 0, len, 0);
}