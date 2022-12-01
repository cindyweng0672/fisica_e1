import fisica.*;
//pallete
color blue   = color(29, 178, 242);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);
//assets
PImage redBird;
PImage cloud; 

int cx1; 
int cy1;

//fisica
FWorld world;
void setup() {
  //make window
  fullScreen();
  
  //load resources
  redBird = loadImage("red-bird.png");
  cloud=loadImage("cloud.png");
  //initialize world
  makeWorld();
  //add terrain to world
  makeTopPlatform();
  makeBottomPlatform();
}
//=====================================================================================================================================
void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}
//=====================================================================================================================================
void makeTopPlatform() {
  FPoly p = new FPoly();
  //plot the vertices of this platform
  p.vertex(-100, height*.1);
  p.vertex(width*0.8, height*0.4);
  p.vertex(width*0.8, height*0.4+100);
  p.vertex(-100, height*0.1+100);
  // define properties
  p.setStatic(true);
  p.setFillColor(brown);
  p.setFriction(0.1);
  //put it in the world
  world.add(p);
}
//=====================================================================================================================================
void makeBottomPlatform() {
  FPoly p = new FPoly();
  //plot the vertices of this platform
  /*p.vertex(width+100, height*0.6);
  p.vertex(300, height*0.8);
  p.vertex(300, height*0.8+100);
  p.vertex(width+100, height*0.6+100);*/
  p.vertex(500, height*0.5); 
  p.vertex(500, height*0.6); 
  p.vertex(100, height*0.6); 
  p.vertex(100, height*0.5);
  p.vertex(120, height*0.5); 
  p.vertex(120, height*0.55);
  p.vertex(480, height*0.55); 
  p.vertex(480, height*0.5); 
  
  // define properties
  p.setStatic(true);
  p.setFillColor(brown);
  p.setFriction(0);
  //put it in the world
  world.add(p);
}

//=====================================================================================================================================
void draw() {
  println("x: " + mouseX + " y: " + mouseY);
  background(blue);
  if (frameCount % 20 == 0) {  //Every 20 frames ...
    makeCircle();
    makeBlob();
    makeBox();
    makeBird();
  }
  
  image(cloud, cx1, cy1);
  
  world.step();  //get box2D to calculate all the forces and new positions
  world.draw();  //ask box2D to convert this world to processing screen coordinates and draw
}

//=====================================================================================================================================
void makeCircle() {
  FCircle circle = new FCircle(50);
  circle.setPosition(random(width), -5);
  //set visuals
  circle.setStroke(0);
  circle.setStrokeWeight(2);
  circle.setFillColor(red);
  //set physical properties
  circle.setDensity(0.2);
  circle.setFriction(1);
  circle.setRestitution(1);
  //add to world
  world.add(circle);
}
//=====================================================================================================================================
void makeBlob() {
  FBlob blob = new FBlob();
  //set visuals
  blob.setAsCircle(random(width), -5, 50);
  blob.setStroke(0);
  blob.setStrokeWeight(2);
  blob.setFillColor(yellow);
  //set physical properties
  blob.setDensity(0.2);
  blob.setFriction(1);
  blob.setRestitution(0.25);
  //add to the world
  world.add(blob);
}
//=====================================================================================================================================
void makeBox() {
  FBox box = new FBox(25, 100);
  box.setPosition(random(width), -5);
  //set visuals
  box.setStroke(0);
  box.setStrokeWeight(2);
  box.setFillColor(green);
  //set physical properties
  box.setDensity(0.2);
  box.setFriction(1);
  box.setRestitution(0.25);
  world.add(box);
}
//=====================================================================================================================================
void makeBird() {
  FCircle bird = new FCircle(48);
  bird.setPosition(random(width), -5);
  //set visuals
  bird.attachImage(redBird);
  //set physical properties
  bird.setDensity(0.8);
  bird.setFriction(1);
  bird.setRestitution(0.5);
  world.add(bird);
}
