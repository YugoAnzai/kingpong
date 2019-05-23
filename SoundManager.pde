import processing.sound.*;

class SoundManager{

	PApplet p;

	Minim minim;

	ArrayList<String> soundNames = new ArrayList();
	ArrayList<AudioPlayer> soundSounds = new ArrayList();

	ArrayList<String> loopNames = new ArrayList();
	ArrayList<AudioPlayer> loopSounds = new ArrayList();

	SoundManager(PApplet p) {
		minim = new Minim(p);

		// soundNames.add("crow_grab");
		// soundNames.add("crow_hit");
		// soundNames.add("crow_wing");
		// soundNames.add("hunter_hit");
		// soundNames.add("hunter_shot");
		// soundNames.add("hunter_walk_1");
		// soundNames.add("hunter_walk_2");
		// soundNames.add("hunter_walk_3");
		// soundNames.add("hunter_walk_4");
		// soundNames.add("level_intro");
		// soundNames.add("loose");
		// soundNames.add("lumberjack_axe_hit");
		// soundNames.add("pine_falling");
		// soundNames.add("pine_hit");
		// soundNames.add("return");
		// soundNames.add("select");
		// soundNames.add("tick");
		// soundNames.add("tree_growing");
		// soundNames.add("ui_points");
		// soundNames.add("victory");
		//
		// loadAudioPlayers("sfx", soundNames, soundSounds);
		//
		// loopNames.add("boss");
		// loopNames.add("cutscene");
		// loopNames.add("forest");
		// loopNames.add("level1");
		// loopNames.add("level2");
		// loopNames.add("level3");
		// loopNames.add("menu");
		//
		// loadAudioPlayers("music", loopNames, loopSounds);

	}

	void loadAudioPlayers(String folder, ArrayList<String> names, ArrayList<AudioPlayer> sounds) {
		for (String name : names) {
			sounds.add(minim.loadFile("sound/" + folder +"/" + name + ".wav"));
		}
	}

	void playSound(String soundName) {
		int index = nameIndex(soundName, soundNames);
		soundSounds.get(index).play(0);
	}

	void playLoop(String loopName) {
		int index = nameIndex(loopName, loopNames);
		loopSounds.get(index).loop();
	}

	void pauseLoop(String loopName) {
		int index = nameIndex(loopName, loopNames);
		loopSounds.get(index).pause();
	}

	int nameIndex(String name, ArrayList<String> names) {
		for (int i = 0; i < names.size(); i++) {
			if (names.get(i) == name) return i;
		}
		println(name + " Not found in");
		return -1;
	}

}
