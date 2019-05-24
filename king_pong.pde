import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Globals globals;
Input input;
Debug debug;
ColliderManager colliderManager;
SceneManager sceneManager;
SoundManager soundManager;

void setup() {

  size(800, 500);
  rectMode(CENTER);
  imageMode(CENTER);
  noStroke();

  textFont(createFont("Retro Gaming.ttf", 48));

  globals = new Globals();
  colliderManager = new ColliderManager();
  input = new Input();
  debug = new Debug();
  soundManager = new SoundManager(this);

  sceneManager = new SceneManager("MenuScene");

}

void draw() {

  process();
  _draw();
  debugDraw();

}

void process(){
  input.process();
  sceneManager.process();

  if (input.keyEnter.debug) {
    globals.debug = !globals.debug;
    if (!globals.debug) {
      stroke(0);
    }
  }

}

void _draw(){
  sceneManager.draw();
}

void debugDraw(){

  if (globals.debug) {
    input.debugDraw(0, 0);
    sceneManager.debugDraw();
  }

}

void keyPressed(){
  input.keyPressed();
}

void keyReleased(){
  input.keyReleased();
}
