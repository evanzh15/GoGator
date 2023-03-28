Albert albert;
void setup() {
  size(600, 600);
  rectMode(CENTER);
  albert =  new Albert(width/2, height/2, width, height);
}

void draw() {
  //Load menu background here
  //background(...)
  background(0);
  albert.drawAlbert();
}

void mousePressed() {
  //Implement based on where mouse is on menu
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == UP)
      albert.moveUp();
    else if(keyCode == DOWN)
      albert.moveDown();
    else if(keyCode == LEFT)
      albert.moveLeft();
    else if(keyCode == RIGHT)
      albert.moveRight();
    else {
      // Escape button for menu(?)
    }
  }
}
