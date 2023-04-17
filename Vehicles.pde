class Vehicles {
  ArrayList<Vehicle> list = new ArrayList<Vehicle>();
  int timer = 0;
  int num;

  //Draws the vehicles on the screen.
  void drawVehicles() {
    //Depending on the difficulty chosen, the rate at which the vehicles appear is decided by time/delay
    //Sets the delay for spawning new vehicles based on the difficulty chosen
    if (diff == 1) {
      delay = 3;
    } else if (diff == 2) {
      delay = 5;
    }
    //Creates new vehicles when the time set by the difficulty is met
    int passedTime = millis() - savedTime2;
    if (passedTime > totalTime/delay) {
      addVehicle();
      savedTime2 = millis();
    }

    //Checks for vehicle collisions
    int check = collision(albert.getX(), albert.getY());
    if (check != -1) {
      state = State.DEATH;
      sounds.playSound(sounds.sFiles[0]);
      sounds.changeState(State.GAME, State.DEATH);
    }
    //Checks the position of every vehicle, if outside of board remove it, if not move it forward on the board
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

  //Creates a new vehicle object of a random type, and a random ypos based on which side it spawns on, which is also random
  void addVehicle() {
    int type = (int)random(0, 5);
    int spawnPoint = (int)random(0, 2);
    int lane = (int) random(0, 3);
    int sizeX = 0, sizeY = 0;
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
    if (spawnPoint == 1)
      type += 5;

    //If type is a bus, size is 190 pixels, else 110 pixels
    if (type % 5 == 4) {
      sizeX = 190;
      sizeY = 70;
    } else {
      sizeX = 110;
      sizeY = 50;
    }

    list.add(new Vehicle(type, 5, xpos, ypos, spawnPoint, num, sizeX, sizeY));

    num++;
  }

  //Removes vehicles when outside of the board, or after a loss
  void rmVehicles(int vehicleID) {
    for (int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      if (temp.getID() == vehicleID) {
        list.remove(i);
        return;
      }
    }
  }

  //Checks for when a vehicle collides with Albert
  int collision(int albertX, int albertY) {
    for (int i = 0; i < list.size(); i++) {
      Vehicle temp = list.get(i);
      if ((temp.getX() - temp.getSizeX()/2 < albertX + albertWidth/2 && temp.getY() - temp.getSizeY()/2 < albertY + albertHeight/2) &&
        (temp.getX() + temp.getSizeX()/2 > albertX - albertWidth/2 && temp.getY() + temp.getSizeY()/2 > albertY - albertHeight/2)) {
        return temp.getID();
      }
    }
    return -1;
  }

  //Removes all vehicles from the board, then clears the array of vehicles
  void clear() {
    for (int i = 0; i < list.size(); i++) {
      list.get(i).setX(1000);
    }
    list.clear();
  }
}
