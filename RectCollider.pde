class RectCollider extends Collider{

	int width;
	int height;
	int xOffset;
	int yOffset;
	int xStart;
	int xEnd;
	int yStart;
	int yEnd;

	RectCollider(GameObject _gameObject, ColliderMask _colliderMask, int _width, int _height) {
		super(_gameObject, _colliderMask);
		width = _width;
		height = _height;
		colliderMask.addCollider(this);
		posStartEndCalculation();
	}

	RectCollider(GameObject _gameObject, ColliderMask _colliderMask, int _width, int _height, int _xOffset, int _yOffset) {
		super(_gameObject, _colliderMask);
		width = _width;
		height = _height;
		xOffset = _xOffset;
		yOffset = _yOffset;
		colliderMask.addCollider(this);
		posStartEndCalculation();
	}

	void posStartEndCalculation(){
		xStart = int(pos.x - width/2) + xOffset;
		xEnd = int(pos.x + width/2) + xOffset;
		yStart = int(pos.y - height/2) + yOffset;
		yEnd = int(pos.y + height/2) + yOffset;
	}

	RectCollider[] process(){

		pos.copyFromTransform(gameObject.pos);
		posStartEndCalculation();

		RectCollider[] rectColliders = {};

		if (!active) return rectColliders;

		for (ColliderMask otherCollidingMask : colliderMask.collidingMasks) {
			for (RectCollider collider : otherCollidingMask.colliders){
				if (active && checkCollisionRect(collider)) {
					rectColliders = (RectCollider[])append(rectColliders, collider);
				}
			}
		}

		return rectColliders;

	}

	boolean checkCollisionRect(RectCollider collider) {
		boolean xCollide = false;
		boolean yCollide = false;
		if (
				(xStart <= collider.xStart && collider.xStart <= xEnd) ||
				(xStart <= collider.xEnd && collider.xEnd <= xEnd) ||
				(collider.xStart <= xStart && xStart <= collider.xEnd) ||
				(collider.xStart <= xEnd && xEnd <= collider.xEnd)
			)
			xCollide = true;
		if (
				(yStart <= collider.yStart && collider.yStart <= yEnd) ||
				(yStart <= collider.yEnd && collider.yEnd <= yEnd) ||
				(collider.yStart <= yStart && yStart <= collider.yEnd) ||
				(collider.yStart <= yEnd && yEnd <= collider.yEnd)
			)
			yCollide = true;

		return (xCollide && yCollide);

	}

	void debugDraw() {
		if (globals.debug){
			stroke(255, 30, 0);
			fill(0, 255, 30, 80);
	    rect(int(pos.x) + xOffset, int(pos.y) + yOffset, width, height);
		}
	}

	void removeFromColliderMask() {
		colliderMask.removeCollider(this);
	}

	void addToColliderMask() {
		colliderMask.addCollider(this);
	}

}
