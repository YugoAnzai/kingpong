class Crystal extends GameObject {

	int colliderW = 20;
	int colliderH = 30;

	Crystal(int x, int y) {
		super(x, y, "Crystal");
		rectCollider = new RectCollider(this, colliderManager.crystals, colliderW, colliderH);

		anim = new Animator(0, 0, "crystal.png", 1, 1);
		anim.createAnimation("idle", new int[]{0}, new int[]{99});
		anim.setAnimation("idle");

	}

	void collect(int player) {

		if (player == 1) {
			globals.pad1.getCrystal();
			destroy();
		} else {
			globals.pad2.getCrystal();
			destroy();
		}

	}

	void destroy() {
		rectCollider.removeFromColliderMask();
		globals.crystalsManager.crystalsDestroy.add(this);
	}

}
