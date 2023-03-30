class Vehicles {
  ArrayList<Vehicle> list = new ArrayList<Vehicle>();
  int timer = 0;
  int num;
  void drawVehicles() {
    int passedTime = millis() - savedTime;
    if (passedTime > totalTime) {
      addVehicle();
      savedTime = millis();
    }
    int check = collision(albert.getX(), albert.getY());
    if(check != -1) {
      state = State.DEATH;
    }
    for(int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      fill(map(temp.getType(), 0, 11, 50, 255));
      rect(temp.getX(), temp.getY(), 50, 30);
      if (temp.spawnPoint == 0) {
        list.get(i).xpos += temp.getSpeed();
      }
      else if (temp.spawnPoint == 1) {
        list.get(i).xpos -= temp.getSpeed();
      }
    }
  }
  
  void addVehicle() {
    int type = (int)random(0, 2);
    int spawnPoint = (int)random(0, 1);
    float ypos = 0;
    float xpos = -100;
    if (spawnPoint == 0) {
      xpos = 0;
      ypos = random(height + 20, height);
    }
    else {
      xpos = width;
      ypos = random(0, height - 20);
    }
    
    //Change speed (the second parameter) to be a varible depending on the difficulty
    list.add(new Vehicle(type, 5, xpos, ypos, spawnPoint, num));
    num++;
  }
  
  int collision(int albertX, int albertY) {
    for(int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      if(temp.getX() == albertX && temp.getY() == albertY) {
        return temp.getID();
      }
    }
    return -1;
  }
  
}
