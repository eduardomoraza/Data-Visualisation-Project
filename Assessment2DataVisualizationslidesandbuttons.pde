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
  background(0);
  Table xy;
  xy = loadTable("http://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2020-08-15T19%3A06%3A09&rToDate=2020-08-17T19%3A06%3A09&rFamily=wasp&rSensor=ES_B_06_418_7BED&rSubSensor=HUMA", "csv"); //ignore the table for now I am planning to use it much later, once everything is working
  
  //slider
  cp5 = new ControlP5(this);
  
  cp5.addSlider("AirTemp")
     .setPosition(50,100)
     .setSize(20,500)
     .setRange(15,45)
     .setNumberOfTickMarks(30)
     .setSliderMode(Slider.FLEXIBLE)
     ;
  
   cp5.addSlider("Day")
     .setPosition(100,700)
     .setWidth(1000)
     .setRange(1,5) 
     .setValue(1)
     .setNumberOfTickMarks(5)
     .setSliderMode(Slider.FLEXIBLE)
     ;
     
   //button
   cp5.addButton("Option 1")
     .setValue(0)
     .setPosition(1400,100)
     .setSize(50,19)
     ;
     
   cp5.addButton("Option 2")
     .setValue(100)
     .setPosition(1400,150)
     .setSize(50,19)
     ;

  
}

void draw(){
  float R = map(noise(nt * 0.01, nR), 0, 1, 0, maxR);
  float t = map(noise(nt * 0.001, nTheta), 0, 1, -360, 360);
  float x = R * cos(t) + 1440 / 2;
  float y = R * sin(t) + 660 / 2;
  objs.add(new Obj(x, y)); //props put data here with boundaries (check by later again)

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
  fill(random(0,255),random(0,255),random(0,255));
  ellipse(v2.x, v2.y, d, d);
}

}
