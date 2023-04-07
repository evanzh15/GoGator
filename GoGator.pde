/*
  Team Members: 
  Kyle McClelland
  Milo Duty
  Evan Zhang
  Niloufar Saririan
*/
import java.util.Map;

enum State {
  MAIN_MENU,
  GAME,
  ESCAPE_MENU,
  DEATH
}
PImage[] cSprites = new PImage[11];
PImage[] vSprites = new PImage[3];
PImage bckgrnd;
PImage road;
State state;
Collectables collectables;
Vehicles vehicles;
Albert albert;
int savedTime;
int savedTime2;
int totalTime = 3000;

void setup() {
  size(600, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  savedTime = millis();
  frameRate(60);
  collectables = new Collectables();
  vehicles = new Vehicles();
  // GoGator initialized at MAIN_MENU state
  state = State.MAIN_MENU;
  bckgrnd = loadImage("gogator_menu.png");
  road = loadImage("gogator_road.png");
  
  // Instantiating collectables
  cSprites[0] = loadImage("computersprite.png");
  cSprites[1] = loadImage("friessprite.png");
  cSprites[2] = loadImage("headphonesprite.png");
  cSprites[3] = loadImage("hotdogsprite.png");
  cSprites[4] = loadImage("hydroflasksprite.png");
  cSprites[5] = loadImage("icecreamsprite.png");
  cSprites[6] = loadImage("papersprite.png");
  cSprites[7] = loadImage("pastasprite.png");
  cSprites[8] = loadImage("phonesprite.png");
  cSprites[9] = loadImage("pizzasprite.png");
  cSprites[10] = loadImage("calculatorsprite.png");
  
  // Instantiating vehicles
  vSprites[0] = loadImage("bluecar.png");
  vSprites[1] = loadImage("greycar.png");
  vSprites[2] = loadImage("bussprite.png");
}

void draw() {
  // Draw everything according to game state.
  background(bckgrnd);
  if(state == State.MAIN_MENU) {
    pushMatrix();
    rectMode(CORNER);
    fill(255);
    rect(200, 400, 200, 50);
    rect(200, 500, 200, 50);
    textSize(100);
    text("GoGator!", 300, 200);
    fill(0);
    textSize(40);
    text("START", 300, 440);
    text("EXIT", 300, 540);
    popMatrix();
    // Albert initialized at center of screen
    albert = new Albert(width/2, height/2, width, height);
  } else if(state == State.GAME) {
    background(road);
    imageMode(CENTER);
    albert.drawAlbert();
    pushMatrix();
    rectMode(CORNER);
    fill(255, 0, 0);
    textAlign(LEFT);
    textSize(30);
    text(collectables.getPtsAccrued(), 10, 30);
    textSize(20);
    textAlign(CENTER);
    text("Press TAB to pause.", 300, 20);
    popMatrix();
    collectables.drawCollectables();
    vehicles.drawVehicles();
  } else if(state == State.ESCAPE_MENU) {
    background(road);
    pushMatrix(); //<>//
    rectMode(CORNER);
    fill(255);
    rect(200, 400, 200, 50);
    rect(200, 500, 200, 50);
    textSize(100);
    text("PAUSED.", 300, 200);
    fill(0);
    textSize(40);
    text("RESUME", 300, 440);
    text("MAIN MENU", 300, 540);
    popMatrix();
  } else if(state == State.DEATH) {
    background(road);
    pushMatrix();
    rectMode(CORNER);
    fill(255);
    textSize(100);
    text("ALBERT DIED.", 300, 300);
    textSize(20);
    text("Press enter to continue.", 300, 580);
    popMatrix();
  }
}

void mousePressed() {
  // If mouse is within desired coordinates during a specific
  // game state, it will produce button specific outcomes.
  if(state == State.MAIN_MENU) {
    if(mouseX >= 200 && mouseX <= 400 && mouseY >= 400 && mouseY <= 450) {
      state = State.GAME;
    } else if(mouseX >= 200 && mouseX <= 400 && mouseY >= 500 && mouseY <= 550) {
      exit();
    }
  } else if(state == State.ESCAPE_MENU) {
    if(mouseX >= 200 && mouseX <= 400 && mouseY >= 400 && mouseY <= 450) {
      state = State.GAME;
    } else if(mouseX >= 200 && mouseX <= 400 && mouseY >= 500 && mouseY <= 550) {
      state = State.MAIN_MENU;
      collectables.clear();
    }
  }
}

void keyPressed() {
  if(state == State.GAME) {
    // Processing needs to check if the key is coded for arrow keys, 
    // alt, control, and shift. All other keys that are pressed can be
    // checked via 'key == (KeyPressed)'
    if(key == CODED) {
      if(keyCode == UP)
        albert.moveUp();
      else if(keyCode == DOWN)
        albert.moveDown();
      else if(keyCode == LEFT)
        albert.moveLeft();
      else if(keyCode == RIGHT)
        albert.moveRight(); //<>//
    } else {
      if(key == TAB)
        state = State.ESCAPE_MENU;
    }
  } else if(state == State.DEATH && keyCode == ENTER) {
    state = State.MAIN_MENU;
    collectables.clear();
  }
}
