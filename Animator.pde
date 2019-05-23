class Animator{

	PImage spritesheet;
	PImage[] sprites;

	int w;
	int h;
	float x = 0;
	float y = 0;
	int xOffset;
	int yOffset;
	boolean flipped = false;

	String[] animNames = null;
	int[][] animSprites = null;
	int[][] animDuration = null;

	protected int curAnimIndex;
	protected int spriteIndex = 0;
	protected int frameCount = 0;
	protected boolean playing = false;
	protected boolean ended = false;
	protected String nextAnimation = null;

	Animator(int _xOffset, int _yOffset, String fileName, int wImages, int hImages){
		xOffset = _xOffset;
		yOffset = _yOffset;
		spritesheet = loadImage("img/" + fileName);
		sprites = new PImage[wImages * hImages];
		w = spritesheet.width/wImages;
		h = spritesheet.height/hImages;

		for (int i = 0; i < sprites.length; i++) {
			int x = (i % wImages) * w;
			int y = (i / wImages) * h;
			sprites[i] = spritesheet.get(x, y, w, h);
		}

	}

	void createAnimation(String _name, int[] _sprites, int[] _duration) {

		expandAnimSprites();

		int index = animNames.length - 1;

		animNames[index] = _name;
		animSprites[index] = _sprites;
		animDuration[index] = _duration;

	}

	void expandAnimSprites() {
		if (animNames == null) {
			animNames = new String[1];
			animSprites = new int[1][0];
			animDuration = new int[1][0];
		} else {
			int newLength = animNames.length + 1;

			String[] newAnimNames = new String[newLength];
			for (int i = 0; i < newLength - 1; i ++) {
				newAnimNames[i] = animNames[i];
			}
			int[][] newAnimSprites = new int[newLength][0];
			for (int i = 0; i < newLength - 1; i ++) {
				newAnimSprites[i] = animSprites[i];
			}
			int[][] newAnimDuration = new int[newLength][0];
			for (int i = 0; i < newLength - 1; i ++) {
				newAnimDuration[i] = animDuration[i];
			}

			animNames = newAnimNames;
			animSprites = newAnimSprites;
			animDuration = newAnimDuration;

		}
	}

	void pause() {
		playing = false;
	}

	void play() {
		playing = true;
	}

	void setAnimation(String name) {
		for(int i = 0; i < animNames.length; i++) {
			if(animNames[i] == name) {
				curAnimIndex = i;
				spriteIndex = 0;
				frameCount = 0;
			}
		}
	}

	void setNextAnimation(String name) {
		nextAnimation = name;
	}

	void draw(){

		if (playing) {
			frameCount++;
		}

		if (frameCount == animDuration[curAnimIndex][spriteIndex]) {

			spriteIndex++;

			if (spriteIndex >= animSprites[curAnimIndex].length && nextAnimation != null) {
				ended = true;
			}

			spriteIndex = spriteIndex % animSprites[curAnimIndex].length;

			frameCount = 0;
		}

		if (nextAnimation != null && ended) {
			setAnimation(nextAnimation);
			nextAnimation = null;
			ended = false;
		}

		if (flipped) {
			pushMatrix();
			scale(-1, 1);
			image(sprites[animSprites[curAnimIndex][spriteIndex]], -((int)x + xOffset), (int)y + yOffset);
			popMatrix();
		} else {
			image(sprites[animSprites[curAnimIndex][spriteIndex]], (int)x + xOffset, (int)y + yOffset);
		}

	}

	void debugDraw(int x, int y) {
		String[] lines = {
			"animation: " + animNames[curAnimIndex],
			"sprite: " + spriteIndex,
			"nextAnimation: " + nextAnimation,
		};
		debug.draw(lines, x, y);
	}


}
