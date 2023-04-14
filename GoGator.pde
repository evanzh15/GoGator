/* //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
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
PImage[] vSprites = new PImage[10];
PImage bckgrnd;
PImage road;
State state;
Collectables collectables;
Vehicles vehicles;
Albert albert;
int savedTime;
int savedTime2;
int totalTime = 3000;
PrintWriter writeE;
PrintWriter writeH;
BufferedReader readE;
BufferedReader readH;
int wCount = 0;
int diff = 0;
Sounds sounds;
String[] checkScoresE;
String[] checkScoresH;
String[] saveScore;
int delay = 0;
boolean newEasyHS = false;
boolean newHardHS = false;

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

  sounds = new Sounds();

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
  vSprites[2] = loadImage("redcar.png");
  vSprites[3] = loadImage("whitecar.png");
  vSprites[4] = loadImage("bussprite_flipped.png");
  vSprites[5] = loadImage("bluecar_flipped.png");
  vSprites[6] = loadImage("greycar_flipped.png");
  vSprites[7] = loadImage("redcar_flipped.png");
  vSprites[8] = loadImage("whitecar_flipped.png");
  vSprites[9] = loadImage("bussprite.png");
  //writeE = createWriter("highscoreEasy.txt");
  //readE = createReader("highscoreEasy.txt");

  checkScoresE = loadStrings("highscoreEasy.txt");
  checkScoresH = loadStrings("highscoreHard.txt");
  saveScore = new String[1];
}

void draw() {
  // Draw everything according to game state.
  background(bckgrnd);
  if (state == State.MAIN_MENU) {
    pushMatrix();
    rectMode(CORNER);
    fill(250, 250, 255);
    stroke(232, 128, 42); //<>// //<>//
    strokeWeight(3);
    rect(200, 400, 200, 50);
    rect(200, 460, 200, 50);
    rect(200, 520, 200, 50);
    fill(8, 8, 64);
    textSize(38);
    text("EASY", 300, 440);
    text("RUSH HOUR", 300, 500);
    text("EXIT", 300, 560);
    popMatrix();
    // Albert initialized at center of screen //<>// //<>//
    albert = new Albert(width/2, height/2, width, height);
  } else if (state == State.GAME) {
    wCount = 0;
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
  } else if (state == State.ESCAPE_MENU) {
    background(road);
    pushMatrix();
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
    textSize(30);
    fill(255, 0, 0);
    textAlign(LEFT);
    text(collectables.getPtsAccrued(), 10, 30);
    textAlign(CENTER);
    popMatrix();
  } else if (state == State.DEATH) {
    background(road);
    pushMatrix();
    rectMode(CORNER);
    fill(255);
    textSize(100);
    text("ALBERT DIED.", 300, 300);
    textSize(20);
    text("Press enter to continue.", 300, 580); //<>// //<>//
    textSize(30);
    fill(255, 0, 0);
    textAlign(LEFT);
    text(collectables.getPtsAccrued(), 10, 30);
    textAlign(CENTER);
    popMatrix();
    if (wCount == 0) {
      checkFile(diff);
      wCount = -1;
    }
    if (newEasyHS) {
      textSize(30);
      fill(#3ABC1E);
      text("New Easy High Score: " + collectables.getPtsAccrued() + "!", 300, 400);
    }
    if (newHardHS) {
      textSize(30);
      fill(#3ABC1E); //<>// //<>//
      text("New Rush Hour High Score: " + collectables.getPtsAccrued() + "!", 300, 400);
    }
  }
}

void mousePressed() {
  // If mouse is within desired coordinates during a specific
  // game state, it will produce button specific outcomes.
  if (state == State.MAIN_MENU) {
    if (mouseX >= 200 && mouseX <= 400 && mouseY >= 400 && mouseY <= 450) {
      diff = 1;
      state = State.GAME;
      sounds.changeState(State.MAIN_MENU, State.GAME);
    } else if (mouseX >= 200 && mouseX <= 400 && mouseY >= 460 && mouseY <= 510) {
      diff = 2;
      state = State.GAME;
      sounds.changeState(State.MAIN_MENU, State.GAME);
    } else if (mouseX >= 200 && mouseX <= 400 && mouseY >= 520 && mouseY <= 570) {
      exit();
    }
  } else if (state == State.ESCAPE_MENU) {
    if (mouseX >= 200 && mouseX <= 400 && mouseY >= 400 && mouseY <= 450) {
      state = State.GAME;
      sounds.changeState(State.ESCAPE_MENU, State.GAME);
    } else if (mouseX >= 200 && mouseX <= 400 && mouseY >= 500 && mouseY <= 550) {
      state = State.MAIN_MENU;
      sounds.changeState(State.ESCAPE_MENU, State.MAIN_MENU);
      collectables.clear();
      vehicles.clear();
      newEasyHS = false;
      newHardHS = false;
    }
  }
}

void keyPressed() {
  if (state == State.GAME) {
    // Processing needs to check if the key is coded for arrow keys,
    // alt, control, and shift. All other keys that are pressed can be
    // checked via 'key == (KeyPressed)'
    if (key == CODED) {
      if (keyCode == UP)
        albert.moveUp();
      else if (keyCode == DOWN)
        albert.moveDown();
      else if (keyCode == LEFT)
        albert.moveLeft();
      else if (keyCode == RIGHT)
        albert.moveRight();
    } else {
      if (key == TAB)
        state = State.ESCAPE_MENU;
      sounds.changeState(State.GAME, State.ESCAPE_MENU);
    }
  } else if (state == State.DEATH && keyCode == ENTER) {
    state = State.MAIN_MENU;
    collectables.clear();
    vehicles.clear();
    sounds.changeState(State.DEATH, State.MAIN_MENU);
  }
}

void checkFile(int diff) {
  int score = collectables.ptsAccrued;
  if (diff == 1) {
    if (checkScoresE.length != 0) {
      int checkScore = int(checkScoresE[0]);
      if (score > checkScore) {
        newEasyHS = true;
        saveScore[0] = str(score);
        saveStrings("highscoreEasy.txt", saveScore);
      }
    }
    else {
      println("Easy mode high score file is empty, please write a 0 in the file to use this feature.");
    }
  } else {
    if (checkScoresH.length != 0) {
      int checkScore = int(checkScoresH[0]);
      if (score > checkScore) {
        newHardHS = true;
        saveScore[0] = str(score);
        saveStrings("highscoreHard.txt", saveScore);
      }
    }
    else {
      println("Rush mode mode high score file is empty, please write a 0 in the file to use this feature.");
    }
  }
}
