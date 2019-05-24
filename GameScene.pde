class GameScene extends Scene{

	Animator bg;

	Ball ball;
	Pad pad1;
	Pad pad2;
	int padOffset = 25;

	float ballSpeed = 5;

	int player1Score = 0;
	int player2Score = 0;
	boolean scored = true;
	int scoreXOffset = 50;
	int scoredTotalTimer = 100;
	int scoredTimer;
	int scoreTextXOffset = 100;
	int scoreTextYOffset = 100;
	int winScore = 3;

	void setup() {
		bg = new Animator(width/2, height/2, "field.png", 1, 1);
		bg.createAnimation("idle", new int[]{0}, new int[]{99});
		bg.setAnimation("idle");

		ball = new Ball(width/2, height/2);

		pad1 = new Pad(padOffset, height/2, 1);
		pad2 = new Pad(width - padOffset, height/2, 2);

		scoredTimer = scoredTotalTimer;

	}

	void process() {
		super.process();

		ball.process();
		pad1.process();
		pad2.process();

		// Goal process
		if (ball.pos.x < 0 - scoreXOffset) {
			player2Score++;
			if (player2Score == winScore) {
				globals.wonLastGame = 2;
				sceneManager.changeScene("EndGameScene");
			}
			scored = true;
		} else if (ball.pos.x > width + scoreXOffset) {
			player1Score++;
			if (player1Score == winScore) {
				globals.wonLastGame = 1;
				sceneManager.changeScene("EndGameScene");
			}
			scored = true;
		}

		// Restart ball
		if (scored) {
			ball.pos.x = width/2;
			ball.pos.y = height/2;
			if (scoredTimer < 0) {
				scored = false;
				scoredTimer = scoredTotalTimer;
				ball.setSpeed(ballSpeed);
			} else {
				scoredTimer--;
			}
		}

		// Quit game
		if (input.keyEnter.esc) {
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){

		bg.draw();

		// Scores
		textAlign(CENTER);
		fill(globals.c2);
		textSize(60);
		text(player1Score, scoreTextXOffset, scoreTextYOffset);
		text(player2Score, width - scoreTextXOffset, scoreTextYOffset);
		textAlign(LEFT);

		ball.draw();

		pad1.draw();
		pad2.draw();

		if (scored) {

			if (player1Score == 0 && player2Score == 0) {

				textSize(50);
				textAlign(CENTER);
				fill(globals.c2);
				text("Faça 3 pontos.", width/2 + 4, 200 + 4);
				fill(globals.c3);
				text("Faça 3 pontos.", width/2, 200);
				textAlign(LEFT);

			}

			textSize(40);
			textAlign(CENTER);
			fill(globals.c2);
			text("Prepare-se!", width/2 + 4, 300 + 4);
			fill(globals.c3);
			text("Prepare-se!", width/2, 300);
			textAlign(LEFT);

		}

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
