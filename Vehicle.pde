class Vehicle {
  //Car, rts bus, or moped
  int type;
  float speed;
  float ypos;
  //0 for left, 1 for right
  int spawnPoint;
  float xpos;
  int id;
  Vehicle(int type, float speed, float xpos, float ypos, int spawnPoint, int id) {
    this.type = type;
    this.speed = speed;
    this.xpos = xpos;
    this.ypos = ypos;
    this.spawnPoint = spawnPoint;
    this.id = id;
  }
  
  void drawVehicle(int type, float xpos) {
    if (type == 0) {
      //Implement
    }
    else if (type == 1) {
      //Implement
    }
    else if (type == 2) {
      //Implement
    }
    
  }
  
  int getType() {return type;}
  float getSpeed() {return speed;}
  float getX() {return xpos;}
  float getY() {return ypos;}
  int getSpawnPoint() {return spawnPoint;}
  int getID() {return id;}
}
