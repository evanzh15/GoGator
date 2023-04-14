class Collectable {
  int type, id, pts;
  float xpos, ypos, spawnTime;

  Collectable(int type, int xpos, int ypos, int id, int pts, float spawnTime) {
    this.type = type;
    this.xpos = xpos;
    this.ypos = ypos;
    this.id = id;
    this.pts = pts;
    this.spawnTime = spawnTime;
  }
  
  int getID() {
    return id;
  }
  
  float getX() {
    return xpos;
  }
  
  float getY() {
    return ypos;
  }
  
  int getType() {
    return type;
  }
  
  int getPts() {
    return pts;
  }
  
  float getSpawnTime() {
    return spawnTime;
  }
}
