abstract class Scene{

	boolean doneSetup = false;

	Scene(){

	}

	abstract void setup();

	void process() {
		if (!doneSetup) {
			this.setup();
			doneSetup = true;
		}
	}

	abstract void draw();

	abstract void debugDraw();

	void destroy(){
		doneSetup = false;
	}

}
