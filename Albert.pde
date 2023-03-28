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
  }
  
  void moveLeft() {
    if (xpos != 0) {
      xpos -= 1;
    }
  }
  void moveRight() {
    if (xpos != w) {
      xpos += 1;
    }
  }
  void moveDown() {
    if (ypos != h) {
      ypos += 1;
    }
  }
  void moveUp() {
    if (ypos != 0) {
      ypos -= 1;
    }
  }
}
