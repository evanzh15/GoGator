class Collectables {
  ArrayList<Collectable> items = new ArrayList<Collectable>();
  int ptsAccrued;
  int onBoard = 0;
  int haveBeenSpawned = 0;

  //Draws each collectable on the board, adding more when necessary, and removing once collected or expired
  void drawCollectables() {
    // Go through each element in ArrayList and draw according to collectable type
    // Timer logic should go here, spawns 1 collectable every 3 seconds. Once 'haveBeenSpawned' reaches 10, a collectable will spawn every 2.
    // Once 'haveBeenSpawned' reaches 50, a collectable will spawn ever 1.5 seconds. Spawning runs addCollectable().
    int passedTime = millis() - savedTime;
    if (passedTime > totalTime) {
      addCollectable();
      savedTime = millis();
    }
    //Checks for when Albert touches an item
    int check = collision(albert.getX(), albert.getY());
    if (check != -1) {
      rmCollectable(check, true);
    }
    //Removes collectables from board after a set time period
    for (int i = 0; i < items.size(); i++) {
      Collectable temp = items.get(i);
      image(cSprites[temp.getType()], temp.getX(), temp.getY());
      if (millis() - temp.getSpawnTime() > 10000)
        rmCollectable(i, false);
    }
  }
  //Creates a new collectable object, with a random type, and drawn at a random position
  void addCollectable() {
    int type = (int)random(0, 11);
    int cPts = -1;
    cPts = (int)map(type, 0, 10, 50, 300);s
    items.add(new Collectable(type, (int)random(1, 20)*30, (int)random(1, 20)*30, haveBeenSpawned, cPts, millis()));
    onBoard++;
    haveBeenSpawned++;
  }
  //Removed collectables when collected or expired
  void rmCollectable(int rmID, boolean collected) {
    for (int i = 0; i < items.size(); i++) {
      Collectable temp = items.get(i);
      if (temp.getID() == rmID) {
        if (collected) {
          ptsAccrued += temp.getPts();
        }
        items.remove(i);
        onBoard--;
        return;
      }
    }
  }
  //Checks when an item is collected by Albert
  int collision(int albertX, int albertY) {
    for (int i = 0; i < items.size(); i++) {
      Collectable temp = items.get(i);
      if ((temp.getX() - 15 < albertX + albertWidth/2 && temp.getY() - 15 < albertY + albertHeight/2) && (temp.getX() + 15 > albertX - albertWidth/2 && temp.getY() + 15 > albertY - albertHeight/2)) {
        sounds.playSound(sounds.sFiles[4]);
        return temp.getID();
      }
    }
    return -1;
  }
  //Returns the points earned during the game.
  int getPtsAccrued() {
    return ptsAccrued;
  }
  //Clears all collectables from the board, resets the points earned, and clears the array of collectables
  void clear() {
    items.clear();
    ptsAccrued = 0;
    onBoard = 0;
    haveBeenSpawned = 0;
  }
}
