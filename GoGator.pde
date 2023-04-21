/* //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
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
  DEATH,
  HELP
}
PImage[] cSprites = new PImage[11];
PImage[] vSprites = new PImage[10];
PImage bckgrnd, help, road;
State state;
Collectables collectables;
Vehicles vehicles;
Albert albert;
int savedTime, savedTime2;
int totalTime = 3000;
PrintWriter writeE;
PrintWriter writeH;
BufferedReader readE;
BufferedReader readH;
int wCount = 0;
int diff = 0;
Sounds sounds;
String[] checkScoresE, checkScoresH, saveScore;
int delay = 0;
boolean newEasyHS = false;
boolean newHardHS = false;
boolean newEasyHSPrint = false;
boolean newHardHSPrint = false;


//Loads in all the sprites and sounds, sets up time tracking and IO files, and creates objects for collectables and vehicles.
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
  help = loadImage("key_menu.png");

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

  //checkScoresE = loadStrings("highscoreEasy.txt");
  //checkScoresH = loadStrings("highscoreHard.txt");
  saveScore = new String[1];
}

void draw() {
  // Draw everything according to game state.
  checkScoresE = loadStrings("highscoreEasy.txt");
  checkScoresH = loadStrings("highscoreHard.txt");
  background(bckgrnd);
  //Draws main menu //<>//
  if (state == State.MAIN_MENU) {
    pushMatrix();
    rectMode(CORNER);
    fill(250, 250, 255);
    stroke(232, 128, 42);
    strokeWeight(3);
    rect(200, 400, 200, 50);
    rect(200, 460, 200, 50);
    rect(200, 520, 200, 50);
    rect(width-60, height-60, 50, 50);
    fill(8, 8, 64); //<>//
    textSize(38);
    text("EASY", 300, 440);
    text("RUSH HOUR", 300, 500);
    text("EXIT", 300, 560);
    text("?", 565, 577);
    popMatrix();
    // Albert initialized at center of screen
    albert = new Albert(width/2, height/2, width, height);
  }
  //Draws game
  else if (state == State.GAME) {
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
  }
  //Draws the pause menu (accessed with "tab")
  else if (state == State.ESCAPE_MENU) {
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
    text(collectables.getPtsAccrued(), 10, 30); //<>//
    textAlign(CENTER);
    popMatrix();
  }
  //Draws the death screen
  else if (state == State.DEATH) {
    background(road);
    pushMatrix();
    rectMode(CORNER);
    fill(255);
    textSize(100);
    text("ALBERT DIED.", 300, 300);
    textSize(20);
    text("Press enter to continue.", 300, 580);
    textSize(30);
    fill(255, 0, 0);
    textAlign(LEFT);
    text(collectables.getPtsAccrued(), 10, 30);
    textAlign(CENTER); //<>//
    popMatrix();
    //Checks the high score to write to high score file and display new high score message, if applicable.
    if (wCount == 0) {
      checkFile(diff);
      wCount = -1;
    }
    if (newEasyHSPrint) {
      textSize(30);
      fill(#3ABC1E);
      text("New Easy High Score: " + collectables.getPtsAccrued() + "!", 300, 400);
    } else if (newHardHSPrint) {
      textSize(30);
      fill(#3ABC1E);
      text("New Rush Hour High Score: " + collectables.getPtsAccrued() + "!", 300, 400);
    }
  }
  else if (state == State.HELP) {
     background(help);
     fill(250, 250, 255);
     stroke(232, 128, 42);
     strokeWeight(3);
     rect(10, 10, 50, 50);
     pushMatrix();
     strokeWeight(5);
     line(20, 35, 50, 35);
     line(20, 35, 30, 25);
     line(20, 35, 30, 45);
     popMatrix();
     textSize(38);
     text("MOVE", 450, 175);
     text("EXIT GAME", 450, 400);
     text("PAUSE", 450, 520);
  }
}

//Checks where the mouse is when a mouse press is detected.
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
    } else if (mouseX >= 540 && mouseX <= 590 && mouseY >= 540 && mouseY <= 590) {
      state = State.HELP;
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
  } else if (state == State.HELP) {
    if (mouseX >= 10 && mouseX <= 60 && mouseY >= 10 && mouseY <= 60) {
      state = State.MAIN_MENU;
    }
  }
}

//Checks what key is pressed for moving Albert, and resetting the game after a loss
void keyPressed() {
  //Moves Albert
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
    }
    if (key == 'w')
      albert.moveUp();
    else if (key == 's')
      albert.moveDown();
    else if (key == 'a')
      albert.moveLeft();
    else if (key == 'd')
      albert.moveRight();
    //Pauses the game
    else {
      if (key == TAB)
        state = State.ESCAPE_MENU;
      sounds.changeState(State.GAME, State.ESCAPE_MENU);
    }
  }
  //Resets the game, returning the player to the main menu following a loss
  else if (state == State.DEATH && keyCode == ENTER) {
    state = State.MAIN_MENU;
    collectables.clear();
    vehicles.clear();
    sounds.changeState(State.DEATH, State.MAIN_MENU);
    newEasyHSPrint = false;
    newHardHSPrint = false;
  }
}

//Compares the score earned during the game to the stored high score, replaces it if necessary.
void checkFile(int diff) {
  int score = collectables.ptsAccrued;
  if (diff == 1) {
    if (checkScoresE.length != 0) {
      int checkScore = int(checkScoresE[0]);
      if (score > checkScore) {
        newEasyHS = true;
        newEasyHSPrint = true;
        saveScore[0] = str(score);
        saveStrings("highscoreEasy.txt", saveScore);
      }
    } else {
      println("Easy mode high score file is empty, please write a 0 in the file to use this feature.");
    }
  } else if (diff == 2) {
    if (checkScoresH.length != 0) {
      int checkScore = int(checkScoresH[0]);
      if (score > checkScore) {
        newHardHS = true;
        newHardHSPrint = true;
        saveScore[0] = str(score);
        saveStrings("highscoreHard.txt", saveScore);
      }
    } else {
      println("Rush mode mode high score file is empty, please write a 0 in the file to use this feature.");
    }
  }
}
