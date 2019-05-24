class CrystalsManager{

  ArrayList<Crystal> crystals = new ArrayList();
  ArrayList<Crystal> crystalsDestroy = new ArrayList();

  int crystalSpawnTotalTimer = 100;
  int crystalSpawnTimer;

  int spawnHalfWidth = 100;

  CrystalsManager() {

    crystalSpawnTimer = crystalSpawnTotalTimer;
    globals.crystalsManager = this;

  }

  void process() {

    if (crystalSpawnTimer < 0) {
      int x = (int) random(width/2 - spawnHalfWidth, width/2 + spawnHalfWidth);
      int y = (int) random(globals.ceilingY, globals.floorY);
      crystals.add(new Crystal(x, y));
      crystalSpawnTimer = crystalSpawnTotalTimer;
    } else {
      crystalSpawnTimer--;
    }

    // Destroy
    for (Crystal crystalDestroy : crystalsDestroy) {
			crystals.remove(crystalDestroy);
		}
		crystalsDestroy.clear();

  }

  void draw() {
    for (Crystal crystal : crystals){
			crystal.draw();
		}
  }

  void debugDraw() {
    for (Crystal crystal : crystals){
			crystal.debugDraw();
		}
  }

}
