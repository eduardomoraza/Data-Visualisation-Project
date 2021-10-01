import java.util.ArrayList;
import controlP5.*;

ControlP5 cp5;

int objnum = 360;
final float noiseScale = 0.01;
float R;
float maxR;
float t = 0;
float nt = 0;
float nR = 0;
float nTheta = 1000;


boolean optiondataA = true;
boolean optiondataB = false;
boolean optiondataC = false;
boolean optiondataD = false;

boolean optioncolorA = true;
boolean optioncolorB = false;
boolean optioncolorC = false;
boolean optioncolorD = false;

Table data;
int index = 0;

PVector v1, v2; //Only way I can add two vectors!
float workMax; // all the work stuff is variable to see how long each ball last
float work;
float working;
float dMax;
float d;
float c;
boolean letgo = false;
ArrayList<Obj> objs = new ArrayList<Obj>(); 

void setup() {
  size(1500,800);
  noStroke();
  maxR = max(1440, 660) * 0.45;
  background(125);
  data = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-09-27T00%3A25%3A50&rToDate=2021-09-29T00%3A25%3A50&rFamily=wasp&rSensor=ES_B_06_419_7C09&rSubSensor=TCA", "csv"); //ignore the table for now I am planning to use it much later, once everything is working
  frameRate(750); //Set frame rate to 750

  cp5 = new ControlP5(this);
  
    //data buttons 
    cp5.addButton("Option A").setPosition(30,60).setSize(75,40);
    cp5.addButton("Option B").setPosition(30,110).setSize(75,40);
    cp5.addButton("Option C").setPosition(30,160).setSize(75,40);
    cp5.addButton("Option D").setPosition(30,210).setSize(75,40); 
    
    //color range buttons 
    cp5.addButton("Color Set A").setPosition(110,60).setSize(85,40);
    cp5.addButton("Color Set B").setPosition(110,110).setSize(85,40);
    cp5.addButton("Color Set C").setPosition(110,160).setSize(85,40);
    cp5.addButton("Color Set D").setPosition(110,210).setSize(85,40);
    
    //reset button
    cp5.addButton("Reset").setPosition(1305, 210).setSize(165,100);
    
    //shape buttons
    cp5.addButton("Shape A").setPosition(1305, 60).setSize(75,40);
    cp5.addButton("Shape B").setPosition(1305, 110).setSize(75,40);
    cp5.addButton("Shape C").setPosition(1305, 160).setSize(75,40);
    
    //display buttons 
    cp5.addButton("Display A").setPosition(1395, 60).setSize(75,40);
    cp5.addButton("Display B").setPosition(1395, 110).setSize(75,40);
    cp5.addButton("Display C").setPosition(1395, 160).setSize(75,40);
 }

void draw(){
    
    //case for buttons and text
    fill(87);
    rect(25, 25, 175, 250);//left
    rect(1300, 25, 175, 300);//right
    
    //RGB
    fill(255, 0, 0);
    rect(50, 675, 75, 75);//red
    fill(0, 255, 0);
    rect(135, 675, 75, 75);//green
    fill(0, 0, 255);
    rect(220, 675, 75, 75);//blue
    
    fill(0);
    textSize(15);
    text("RGB Color Code: [###], [###], [###]", 50, 770);
    
    //text
    fill(0);
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




public void mousePressed() {
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
  float theta = map(noise(v2.x * noiseScale, v2.y * noiseScale, t), 0, 1, -360, 360);
  v1.x = cos(theta);
  v1.y = sin(theta);
  v2.add(v1);
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
  int codecolor = data.getInt(index, 1); //gets average of colour code 
  int R = 155 - codecolor; //Red colour 
  int B = 155 + codecolor; //Blue colour 
  println(codecolor);
  fill(random(R), 0, random(B)); //This needs editing 
  ellipse(v2.x, v2.y, d, d);
}


}
