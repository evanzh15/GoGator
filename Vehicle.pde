class Vehicle {
  //Type: variants of car, or rts bus
  //spawnPoint: 0 for left, 1 for right
  int type, spawnPoint, id, sizeX, sizeY;
  float xpos, ypos, speed;

  //Vehicle constructor
  Vehicle(int type, float speed, float xpos, float ypos, int spawnPoint, int id, int sizeX, int sizeY) {
    this.type = type;
    this.speed = speed;
    this.xpos = xpos;
    this.ypos = ypos;
    this.spawnPoint = spawnPoint;
    this.id = id;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  //Returns attributes of vehicle objects.
  int getType() {
    return type;
  }
  float getSpeed() {
    return speed;
  }
  float getX() {
    return xpos;
  }
  float getY() {
    return ypos;
  }
  void setX(float x) {
    xpos = x;
  }
  int getSpawnPoint() {
    return spawnPoint;
  }
  int getID() {
    return id;
  }
  int getSizeX() {
    return sizeX;
  }
  int getSizeY() {
    return sizeY;
  }
}
