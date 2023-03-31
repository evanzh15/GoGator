enum State {
  MAIN_MENU,
  GAME,
  ESCAPE_MENU,
  DEATH
}
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
    fill(255, 255, 0);
    rect(570, 0, 30, 30);
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
    // Yellow box of death at the top right corner invokes the DEATH state.
    if((int)albert.getX() == 570 && (int)albert.getY() == 0) {
      state = State.DEATH;
    }
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
    text("Press any key to continue.", 300, 580);
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
  } else if(state == State.DEATH) {
    state = State.MAIN_MENU;
  }
}
