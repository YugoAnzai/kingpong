class ColliderManager{

	ColliderMask pads;
	ColliderMask ball;
	ColliderMask crystals;

	ColliderManager(){

		pads = new ColliderMask();
		ball = new ColliderMask();
		crystals = new ColliderMask();

		pads.addCollidingMask(ball);
		ball.addCollidingMask(crystals);

	}

	void resetAllColliderMasks() {
		pads.resetColliders();
		ball.resetColliders();
		crystals.resetColliders();
	}

}
