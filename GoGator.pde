enum State {
  MAIN_MENU,
  GAME,
  ESCAPE_MENU,
  DEATH
}
 
State state;
Albert albert;

void setup() {
  size(600, 600);
  rectMode(CENTER);
  
  // Albert initialized at center of screen
  albert =  new Albert(width/2, height/2, width, height);
  
  // GoGator initialized at MAIN_MENU state
  state = State.MAIN_MENU;
}

void draw() {
  // Draw everything according to game state.
  background(0);
  if(state == State.MAIN_MENU) {
    pushMatrix();
    rectMode(CORNER);
    fill(255);
    rect(200, 400, 200, 50);
    rect(200, 500, 200, 50);
    textAlign(CENTER);
    textSize(100);
    text("GoGator!", 300, 200);
    fill(0);
    textSize(40);
    text("START", 300, 440);
    text("EXIT", 300, 540);
    popMatrix();
  } else if(state == State.GAME) {
    albert.drawAlbert();
  } else if(state == State.ESCAPE_MENU) {
    pushMatrix(); //<>//
    rectMode(CORNER);
    fill(255);
    rect(200, 400, 200, 50);
    rect(200, 500, 200, 50);
    textAlign(CENTER);
    textSize(100);
    text("PAUSED.", 300, 200);
    fill(0);
    textSize(40);
    text("RESUME", 300, 440);
    text("MAIN MENU", 300, 540);
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
  }
}
