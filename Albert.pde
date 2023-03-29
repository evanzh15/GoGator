class Albert {
  float xpos, ypos;
  float w, h;
  Albert(float xpos, float ypos, float w, float h) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.w = w;
    this.h = h;
  }
  
  void drawAlbert() {
    //implement draw albert function once we have image for him
    fill(255);
    rectMode(CENTER);
    rect(xpos, ypos, 20, 20); // Placeholder
  }
  
  void moveLeft() {
    if (xpos != 0) {
      xpos -= 20;
    }
    print(xpos, ypos, '\n');
  }
  void moveRight() {
    if (xpos != w) {
      xpos += 20;
    }
    print(xpos, ypos, '\n');
  }
  void moveDown() {
    if (ypos != h) {
      ypos += 20;
    }
    print(xpos, ypos, '\n');
  }
  void moveUp() {
    if (ypos != 0) {
      ypos -= 20;
    }
    print(xpos, ypos, '\n');
  }
  float getX() {
    return xpos;
  }
  float getY() {
    return ypos;
  }
}
