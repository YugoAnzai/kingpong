class SceneManager{

	Scene currentScene = null;
	Scene nextScene = null;

	SceneManager(String sceneName){
		currentScene = createScene(sceneName);
	}

	Scene createScene(String sceneName) {
		Scene scene = null;
		if(sceneName == "MenuScene") scene = new MenuScene();
		else if(sceneName == "CreditsScene") scene = new CreditsScene();

		return scene;
	}

	void changeScene(String sceneName) {
		nextScene = createScene(sceneName);
	}

	void process() {
		if (nextScene != null) {
			currentScene.destroy();
			currentScene = nextScene;
			nextScene = null;
		}
		currentScene.process();
	}

	void draw() {
		currentScene.draw();
	}

	void debugDraw() {
		currentScene.debugDraw();
	}

}
