class GameScene extends Scene{

	Animator bg;

	Ball ball;
	Pad pad1;
	Pad pad2;
	int padOffset = 25;

	void setup() {
		bg = new Animator(width/2, height/2, "field.png", 1, 1);
		bg.createAnimation("idle", new int[]{0}, new int[]{99});
		bg.setAnimation("idle");

		ball = new Ball(width/2, height/2);
		ball.setSpeed(3, 3);

		pad1 = new Pad(padOffset, height/2, 1);
		pad2 = new Pad(width - padOffset, height/2, 2);

	}

	void process() {
		super.process();

		ball.process();
		pad1.process();
		pad2.process();

		if (input.keyEnter.esc) {
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){

		bg.draw();

		ball.draw();
		pad1.draw();
		pad2.draw();

	}

	void debugDraw() {

		ball.debugDraw();
		pad1.debugDraw();
		pad2.debugDraw();

		debugDrawGrid();
	}

	void debugDrawGrid(){
		int interval = 50;
		stroke(0, 0, 255, 80);
		for (int x = 0; x < width; x += interval) {
			line(x, 0, x, height);
		}
		for (int y = 0; y < height; y += interval ){
			line(0, y, width, y);
		}
	}

	void destroy(){
		super.destroy();
	}

}
