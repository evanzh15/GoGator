class Albert {
  int xpos, ypos;
  float w, h;
  PImage albertSprite = loadImage("gatorsprite.png");
  Albert(int xpos, int ypos, float w, float h) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.w = w;
    this.h = h;
  }
  
  void drawAlbert() {
    //implement draw albert function once we have image for him
    fill(255);
    rect(xpos, ypos, 30, 30); // Placeholder
    //image(albertSprite, xpos, ypos);
  }
  
  void moveLeft() {
    if (xpos != 0) {
      xpos -= 30;
    }
    print(xpos, ypos, '\n');
  }
  void moveRight() {
    if (xpos != w - 30) {
      xpos += 30;
    }
    print(xpos, ypos, '\n');
  }
  void moveDown() {
    if (ypos != h - 30) {
      ypos += 30;
    }
    print(xpos, ypos, '\n');
  }
  void moveUp() {
    if (ypos != 0) {
      ypos -= 30;
    }
    print(xpos, ypos, '\n');
  }
  int getX() {
    return xpos;
  }
  int getY() {
    return ypos;
  }
}
