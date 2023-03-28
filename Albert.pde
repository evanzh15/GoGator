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
    rect(xpos, ypos, 30, 30); // Placeholder
  }
  
  void moveLeft() {
    if (xpos != 0) {
      xpos -= 30;
    }
  }
  void moveRight() {
    if (xpos != w) {
      xpos += 30;
    }
  }
  void moveDown() {
    if (ypos != h) {
      ypos += 30;
    }
  }
  void moveUp() {
    if (ypos != 0) {
      ypos -= 30;
    }
  }
}
