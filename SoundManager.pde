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

		soundNames.add("bounce1");
		soundNames.add("bounce2");
		soundNames.add("bounce3");
		soundNames.add("crystal");
		soundNames.add("goal1");
		soundNames.add("goal2");

		loadAudioPlayers("sfx", soundNames, soundSounds);

		loopNames.add("game");
		loopNames.add("menu");

		loadAudioPlayers("music", loopNames, loopSounds);

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

	boolean isLoopPlaying(String loopName) {
		int index = nameIndex(loopName, loopNames);
		return loopSounds.get(index).isPlaying();
	}

	int nameIndex(String name, ArrayList<String> names) {
		for (int i = 0; i < names.size(); i++) {
			if (names.get(i) == name) return i;
		}
		println(name + " Not found in");
		return -1;
	}

}
