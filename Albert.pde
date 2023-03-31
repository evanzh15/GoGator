class Albert {
  int xpos, ypos;
  float w, h;
  PImage albertSpriteUp = loadImage("albertSprite_Up.png");
  PImage albertSpriteDown = loadImage("albertSprite_Down.png");
  PImage albertSpriteLeft = loadImage("albertSprite_Left.png");
  PImage albertSpriteRight = loadImage("albertSprite_Right.png");
  //up = 1, down = 2, left = 3, right = 4
  int draw = 1;
  Albert(int xpos, int ypos, float w, float h) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.w = w;
    this.h = h;
  }

  void drawAlbert() {
    //implement draw albert function once we have image for him
    fill(255);
    //rect(xpos, ypos, 30, 30); // Placeholder
    if (draw == 1) {
      albertSpriteUp.resize(90, 90);
      image(albertSpriteUp, xpos, ypos);
    }
    if (draw == 2) {
      albertSpriteDown.resize(90, 90);
      image(albertSpriteDown, xpos, ypos);
    }
    if (draw == 3) {
      albertSpriteLeft.resize(90, 90);
      image(albertSpriteLeft, xpos, ypos);
    }
    if (draw == 4) {
      albertSpriteRight.resize(90, 90);
      image(albertSpriteRight, xpos, ypos);
    }
  }

  void moveLeft() {
    if (xpos != 0) {
      xpos -= 30;
    }
    draw = 3;
    print(xpos, ypos, '\n');
  }
  void moveRight() {
    if (xpos != w - 30) {
      xpos += 30;
    }
    draw = 4;
    print(xpos, ypos, '\n');
  }
  void moveDown() {
    if (ypos != h - 30) {
      ypos += 30;
    }
    draw = 2;
    print(xpos, ypos, '\n');
  }
  void moveUp() {
    if (ypos != 0) {
      ypos -= 30;
    }
    draw = 1;
    print(xpos, ypos, '\n');
  }
  int getX() {
    return xpos;
  }
  int getY() {
    return ypos;
  }
}
