class Collider {

	Transform pos;
	GameObject gameObject;
	ColliderMask colliderMask;
	boolean active = true;

	Collider(GameObject _gameObject, ColliderMask _colliderMask){
		gameObject = _gameObject;
		pos = new Transform(gameObject.pos.x, gameObject.pos.y);
		colliderMask = _colliderMask;
	}

}
