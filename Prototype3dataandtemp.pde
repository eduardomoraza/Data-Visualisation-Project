import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;

int objnum = 360;
final float noiseScale = 0.01;
float Radius;
float maxR;
float t = 0;
float nt = 0;
float nR = 0;
float nTheta = 1000;

boolean optiondataA = true;  // 22/09/21 - 30/09/21 (data value: 21)
boolean optiondataB = false; // 15/09/21 - 22/09/21 (data value: 19)
boolean optiondataC = false; // 05/09/21 - 08/09/21 (data value: 18) 
boolean optiondataD = false; // 01/09/21 - 03/09/21 (data value: 20)

boolean optioncolorA = true; //blue - red
boolean optioncolorB = false;//green - yellow
boolean optioncolorC = false;//orange - pink (reminds me of candy for some weird reason) 
boolean optioncolorD = false;//black - white

boolean optiondisplayA = true;
boolean optiondisplayB = false;
boolean optiondisplayC = false;

Table data1;
Table data2;
Table data3;
Table data4;
int index = 0;

int codecolor = 0;
int R = 0; //Red color 
int G = 0; //Green color 
int B = 0; //Blue color 
int BW = 0; //Black-White color

String rgb = "RGB Color Code:";
int optioncolor;

PVector v1, v2; //Only way I can add two vectors!
float workMax; // all the work stuff is variable to see how long each ball last
float work;
float working;
float dMax;
float d;
float c;
ArrayList<Obj> objs = new ArrayList<Obj>(); 

void setup() {
  size(1500,800);
  noStroke();
  maxR = max(1440, 660) * 0.45;
  background(125);
  data1 = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-09-22T20%3A38%3A49&rToDate=2021-09-30T20%3A38%3A49&rFamily=wasp&rSensor=ES_B_11_428_3EA4&rSubSensor=TCA", "csv");  // 22/09/21 - 30/09/21 (data value: 21)
  data2 = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-09-15T20%3A38%3A49&rToDate=2021-09-22T21%3A17%3A32&rFamily=wasp&rSensor=ES_B_11_428_3EA4&rSubSensor=TCA", "csv");  // 15/09/21 - 22/09/21 (data value: 19)
  data3 = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-09-05T20%3A38%3A49&rToDate=2021-09-08T22%3A37%3A09&rFamily=wasp&rSensor=ES_B_11_428_3EA4&rSubSensor=TCA", "csv");  // 05/09/21 - 08/09/21 (data value: 18) 
  data4 = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-09-01T20%3A38%3A49&rToDate=2021-09-03T22%3A37%3A09&rFamily=wasp&rSensor=ES_B_11_428_3EA4&rSubSensor=TCA", "csv");  // 01/09/21 - 03/09/21 (data value: 20) 
  frameRate(100); //Set frame rate to 100
  
  
  //sliders
  cp5 = new ControlP5(this);
  
    //data buttons 
    cp5.addButton("OptionA").setPosition(30,60).setSize(75,40);
    cp5.addButton("OptionB").setPosition(30,110).setSize(75,40);
    cp5.addButton("OptionC").setPosition(30,160).setSize(75,40);
    cp5.addButton("OptionD").setPosition(30,210).setSize(75,40); 
    
    //color range buttons
    cp5.addButton("ColorSetA").setPosition(110,60).setSize(85,40);
    cp5.addButton("ColorSetB").setPosition(110,110).setSize(85,40);
    cp5.addButton("ColorSetC").setPosition(110,160).setSize(85,40);
    cp5.addButton("ColorSetD").setPosition(110,210).setSize(85,40);

    //reset button
    cp5.addButton("Reset").setPosition(1305, 210).setSize(165,100);
    
    //shape buttons
    cp5.addButton("ShapeA").setPosition(1305, 60).setSize(75,40);
    cp5.addButton("ShapeB").setPosition(1305, 110).setSize(75,40);
    cp5.addButton("ShapeC").setPosition(1305, 160).setSize(75,40);
    
    //display buttons 
    cp5.addButton("DisplayA").setPosition(1395, 60).setSize(75,40);
    cp5.addButton("DisplayB").setPosition(1395, 110).setSize(75,40);
    cp5.addButton("DisplayC").setPosition(1395, 160).setSize(75,40);



  
 }

void draw(){  
   //case for buttons and text
  fill(87);
  rect(25, 25, 175, 250);//left
  rect(1300, 25, 175, 300);//right
    
    
    
    if (optioncolorA) { 
     fill(random(R), G, random(B)); 
     rect(50, 675, 75, 75);
     }
     
   if (optioncolorB) {
     fill(random(R), random(G), B);
     rect(50, 675, 75, 75);
   }
    
   if (optioncolorC) {
     fill(R, random(G), random(B));
     rect(50, 675, 75, 75);
   }
   
   if (optioncolorD) {
     fill(random(BW));
     rect(50, 675, 75, 75);
   }
    
     //color information
     fill(125);
     rect(50,755,250,20);
     
   if (optioncolorA || optioncolorB || optioncolorC) {
     fill(255);
     textSize(15);
     text(rgb + str(R) + ", " + str(G) + ", " + str(B), 50, 770);
   } 

   if (optioncolorD) {
     fill(255);
     textSize(15);
     text(rgb + str(BW), 50, 770);
   }
  
  
  //data tab bottom right
   fill(125);
   rect(1190,730,300,50);
     
  if(optiondataA){
  fill(255);
  textSize(15);
  text("Temperature Average Number:", 1200, 750);
  text("dataA:22/09/21-30/09/21", 1200, 770); 
  }
  
   if(optiondataB){
  fill(255);
  textSize(15);
  text("Temperature Average Number:", 1200, 750);
  text("dataB:15/09/21-22/09/21", 1200, 770); 
  }
  
   if(optiondataC){
  fill(255);
  textSize(15);
  text("Temperature Average Number:", 1200, 750);
  text("dataC:05/09/21-08/09/21", 1200, 770); 
  }
  
   if(optiondataD){
  fill(255);
  textSize(15);
  text("Temperature Average Number:", 1200, 750);
  text("dataD:01/09/21-03/09/21", 1200, 770); 
  }
  
  
    //text
  fill(255);
  textSize(15);
  
    //titles of buttons 
  text("Data",55,50);
  text("Color Range",108,50);
  text("Shapes",1330,50);
  text("Display",1400,50);
    
    //dates
    //text("22/09/21-30/09/21",40,120);//optiona
    //text("15/09/21-22/09/21",40,220);//optionb
    //text("05/09/21-08/09/21",40,320);//optionc
    //text("01/09/21-03/09/21",40,420);//optiond
  
  float R = map(noise(nt * 0.01, nR), 0, 1, 0, maxR);
  float t = map(noise(nt * 0.001, nTheta), 0, 1, -360, 360);
  float x = R * cos(t) + 1440 / 2;
  float y = R * sin(t) + 660 / 2;
  objs.add(new Obj(x, y)); //props put data here with boundaries 
  
  for (int i = 0; i < objs.size(); i++){ //calling functions
    objs.get(i).move();
    objs.get(i).display();
  }

  for (int j = objs.size() - 1; j >=0; j--) {
    if (objs.get(j).Areyoudone() == true) {
      objs.remove(j); //need to check this later
      }
    }
    nt++;
  }

public void OptionA() {
  optiondataA = true;  // 22/09/21 - 30/09/21 (data value: 21)
  optiondataB = false; // 15/09/21 - 22/09/21 (data value: 19)
  optiondataC = false; // 05/09/21 - 08/09/21 (data value: 18) 
  optiondataD = false; // 01/09/21 - 03/09/21 (data value: 20)
}

public void OptionB() {
  optiondataA = false;  // 22/09/21 - 30/09/21 (data value: 21)
  optiondataB = true; // 15/09/21 - 22/09/21 (data value: 19)
  optiondataC = false; // 05/09/21 - 08/09/21 (data value: 18) 
  optiondataD = false; // 01/09/21 - 03/09/21 (data value: 20)
}

public void OptionC() {
  optiondataA = false;  // 22/09/21 - 30/09/21 (data value: 21)
  optiondataB = false; // 15/09/21 - 22/09/21 (data value: 19)
  optiondataC = true; // 05/09/21 - 08/09/21 (data value: 18) 
  optiondataD = false; // 01/09/21 - 03/09/21 (data value: 20)
}

public void OptionD() {
  optiondataA = false;  // 22/09/21 - 30/09/21 (data value: 21)
  optiondataB = false; // 15/09/21 - 22/09/21 (data value: 19)
  optiondataC = false; // 05/09/21 - 08/09/21 (data value: 18) 
  optiondataD = true; // 01/09/21 - 03/09/21 (data value: 20)
}

public void ColorSetA() {
  optioncolorA = true; //blue - red
  optioncolorB = false;//green - yellow
  optioncolorC = false;//orange - pink (reminds me of candy for some weird reason) 
  optioncolorD = false;//black - white
}

public void ColorSetB() {
  optioncolorA = false; //blue - red
  optioncolorB = true;//green - yellow
  optioncolorC = false;//orange - pink (reminds me of candy for some weird reason) 
  optioncolorD = false;//black - white
}

public void ColorSetC() {
  optioncolorA = false; //blue - red
  optioncolorB = false;//green - yellow
  optioncolorC = true;//orange - pink (reminds me of candy for some weird reason) 
  optioncolorD = false;//black - white
}

public void ColorSetD() {
  optioncolorA = false; //blue - red
  optioncolorB = false;//green - yellow
  optioncolorC = false;//orange - pink (reminds me of candy for some weird reason) 
  optioncolorD = true;//black - white
}

public void Reset() {
//put reset code here
}

public void ShapeA() {
//put shapeA code here
}

public void ShapeB() {
//put shapeB code here
}

public void ShapeC() {
//put shapeC code here
}

public void ShapeD() {
//put shapeD code here
}

public void DisplayA() {
  optiondisplayA = true;
  optiondisplayB = false;
  optiondisplayC = false;
}

public void DisplayB() {
  optiondisplayA = false;
  optiondisplayB = true;
  optiondisplayC = false;
}

public void DisplayC() {
  optiondisplayA = false;
  optiondisplayB = false;
  optiondisplayC = true;
}

void mousePressed() {
  objs.add(new Obj(mouseX, mouseY));
}

class Obj {

  public Obj(float ox, float oy) {
  this.init(ox, oy);
  }

  void init( float ox, float oy) {
    v1 = new PVector(0, 0);
    v2 = new PVector(ox, oy);
    t = random(0, noiseScale);
    workMax = random(20, 50);
    work = workMax;
    working = random(0.1, 0.5);
    dMax = random(10) >= 5 ? 10 : 30;
    d = dMax;
    c = color(random(255));
  }
  
  void move() {
    
    if (optiondisplayA) {
      float theta = map(noise(v2.x * noiseScale, v2.y * noiseScale, t), 0, 1, -360, 360);
      v1.x = cos(theta)*7;
      v1.y = sin(theta)*7;
      v2.add(v1);    
    }
    
    if (optiondisplayB) {
      float theta = map(noise(v2.x * noiseScale), 0, 1, -360, 360);
      v1.x = cos(theta);
      v1.y = sin(theta)*3;
      v2.add(v1);
    }
    
    if (optiondisplayC) {
      v1.x = -6;
      v1.y = -6;
      v2.add(v1);
    }
    
  }

  boolean Areyoudone() { //now you see how work is used!
    work -= working;
    d = map(work, 0, workMax, 0, dMax);

    if (work < 0) {
      return true;
    }
    else {
      return false;
    }
  }

  void display() {  
    
int initaldatavalue1 = data1.getInt(index, 1);
int initaldatavalue2 = data2.getInt(index, 1); 
int initaldatavalue3 = data3.getInt(index, 1);
int initaldatavalue4 = data4.getInt(index, 1);
    
  //options that change data values of code
    if (optiondataA) {
      codecolor = initaldatavalue1*9;
    }
  
    if (optiondataB) {
      codecolor = initaldatavalue2*9;  
    }
  
    if (optiondataC) {
      codecolor = initaldatavalue3*9;
    }
  
    if (optiondataD) {
      codecolor = initaldatavalue4*9;  
    }
  
  //gets adjusted value for color code 
  
    if (optioncolorA) { //blue - red
      R = codecolor;
      G = 0;
      B = codecolor; 
      fill(random(R), G, random(B)); 
      ellipse(v2.x, v2.y, d, d);
    }

  
    if (optioncolorB) { //green - yellow
      R = codecolor;
      G = codecolor;
      B = 0;
      fill(random(R), random(G), B);
      ellipse(v2.x, v2.y, d, d);
    }

    
    if (optioncolorC) { //orange - pink (reminds me of candy for some weird reason)  
      R = 185;
      G = 52;
      B = codecolor;
      fill(R, random(G), random(B));
      ellipse(v2.x, v2.y, d, d);
    }
 
    
    if (optioncolorD) { //black - white
      BW = codecolor;
      fill(random(BW));
      ellipse(v2.x, v2.y, d, d);
    }
    println(codecolor);
  }

}
