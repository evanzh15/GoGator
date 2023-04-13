class Vehicles {
  ArrayList<Vehicle> list = new ArrayList<Vehicle>();
  int timer = 0;
  int num;
  
  
  void drawVehicles() {
    //Depending on the difficulty chosen, the rate at which the vehicles appear is decided by time/delay. 
    if (diff == 1) {
      delay = 3;
    }
    else if (diff == 2) {
      delay = 5;
    }
    //Creates new vehicles when the time set by the difficulty is met. 
    int passedTime = millis() - savedTime2;
    if (passedTime > totalTime/delay) {
      addVehicle();
      savedTime2 = millis();
    }

    int check = collision(albert.getX(), albert.getY());
    if (check != -1) {
      state = State.DEATH;
      sounds.playSound(sounds.sFiles[0]);
      sounds.changeState(State.GAME, State.DEATH);
    }
    for (int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      fill(map(temp.getType(), 0, 11, 50, 255));
      if (temp.getX() < -20 || temp.getX() > width + 20) {
        rmVehicles(temp.getID());
      } else {
        image(vSprites[temp.getType()], temp.getX(), temp.getY());
        if (temp.spawnPoint == 0) {
          list.get(i).xpos += temp.getSpeed();
        } else if (temp.spawnPoint == 1) {
          list.get(i).xpos -= temp.getSpeed();
        }
      }
    }
  }

  void addVehicle() {
    int type = (int)random(0, 3);
    int spawnPoint = (int)random(0, 2);
    int lane  = (int) random(0, 3);
    float ypos = 0;
    float xpos = -100;
    if (spawnPoint == 0) {
      xpos = 0;
      switch(lane) {
      case 0:
        ypos = 9*height/14 - 10;
        break;
      case 1:
        ypos = 11*height/14 - 10;
        break;
      case 2:
        ypos = 13*height/14 - 10;
        break;
      }
    } else {
      xpos = width;
      switch(lane) {
      case 0:
        ypos = height/14 - 10;
        break;
      case 1:
        ypos = 3*height/14 - 10;
        break;
      case 2:
        ypos = 5*height/14 - 10;
        break;
      }
    }

    //Change speed (the second parameter) to be a varible depending on the difficulty
    list.add(new Vehicle(type, 5, xpos, ypos, spawnPoint, num));

    num++;
  }

  void rmVehicles(int vehicleID) {
    for (int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      if (temp.getID() == vehicleID) {
        list.remove(i);
        return;
      }
    }
  }

  int collision(int albertX, int albertY) {
    for (int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      if ((temp.getX() < albertX + 40 && temp.getY() < albertY + 40) && (temp.getX() + 25 > albertX - 40 && temp.getY() + 25 > albertY - 40)) {
        return temp.getID();
      }
    }
    return -1;
  }
  
  void clear() {
    for (int i = 0; i < list.size(); i++) {
      list.get(i).setX(1000);
    }
    list.clear();
    
  }
}
