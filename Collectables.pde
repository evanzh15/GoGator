class Collectables {
  ArrayList<Collectable> items = new ArrayList<Collectable>();
  int ptsAccrued;
  int onBoard = 0;
  int haveBeenSpawned = 0; 
  void drawCollectables() {
  // Go through each element in ArrayList and draw according to collectable type
  // Timer logic should go here, spawns 1 collectable every 3 seconds. Once 'haveBeenSpawned' reaches 10, a collectable will spawn every 2.
  // Once 'haveBeenSpawned' reaches 50, a collectable will spawn ever 1.5 seconds. Spawning runs addCollectable().
    int passedTime = millis() - savedTime;
    if (passedTime > totalTime) {
      addCollectable();
      savedTime = millis();
    }
    for(int i = 0; i < items.size(); i++) {
      Collectable temp = items.get(i);
      rect(temp.getX(), temp.getY(), 30, 30);
    }
  }
  void addCollectable() {
    int type = (int)random(0,12);
    int cPts = -1;
    switch (type) {
      case 0:
        cPts = 100;
        break;
      case 1:
        cPts = 150;
        break;
      // Fill in the rest
      case 11:
        cPts = 300;
        break;
      default:
        cPts = 100;
        break;
    }
    items.add(new Collectable(type, (int)random(0,20)*30, (int)random(0,20)*30, haveBeenSpawned, cPts));
    onBoard++;
    haveBeenSpawned++;
  }
  void rmCollectable(int rmID) {
    for (int i = 0; i < items.size(); i++) {
      Collectable temp = items.get(i);
      if (temp.getID() == rmID) {
        ptsAccrued += temp.getPts();
        items.remove(i);
        onBoard--;
        return;
      }
    }
  }
}
