class Pressed {

  boolean p1up = false;
  boolean p1down = false;
  boolean p1action = false;
  boolean p2up = false;
  boolean p2down = false;
  boolean p2action = false;
  boolean enter = false;
  boolean esc = false;
  boolean debug = false;

  Pressed() {

  }

  void copyPressed(Pressed pressed) {

    p1up = pressed.p1up;
    p1down = pressed.p1down;
    p1action = pressed.p1action;
    p2up = pressed.p2up;
    p2down = pressed.p2down;
    p2action = pressed.p2action;
    enter = pressed.enter;
    esc = pressed.esc;
    debug = pressed.debug;

  }

}

class Input{

  Pressed rawInputPressed;
  Pressed pressed;
  Pressed pressedLastFrame;
  Pressed keyEnter;
  Pressed keyExit;

  Input() {
    rawInputPressed = new Pressed();
    pressed = new Pressed();
    pressedLastFrame = new Pressed();
    keyEnter = new Pressed();
    keyExit = new Pressed();
  }

  void process(){

    pressed.copyPressed(rawInputPressed);

    keyEnter.p1up = (pressed.p1up && !pressedLastFrame.p1up);
    keyEnter.p1down = (pressed.p1down && !pressedLastFrame.p1down);
    keyEnter.p1action = (pressed.p1action && !pressedLastFrame.p1action);
    keyEnter.p2up = (pressed.p2up && !pressedLastFrame.p2up);
    keyEnter.p2down = (pressed.p2down && !pressedLastFrame.p2down);
    keyEnter.p2action = (pressed.p2action && !pressedLastFrame.p2action);
    keyEnter.enter = (pressed.enter && !pressedLastFrame.enter);
    keyEnter.esc = (pressed.esc && !pressedLastFrame.esc);
    keyEnter.debug = (pressed.debug && !pressedLastFrame.debug);

    keyExit.p1up = (!pressed.p1up && pressedLastFrame.p1up);
    keyExit.p1down = (!pressed.p1down && pressedLastFrame.p1down);
    keyExit.p1action = (!pressed.p1action && pressedLastFrame.p1action);
    keyExit.p2up = (!pressed.p2up && pressedLastFrame.p2up);
    keyExit.p2down = (!pressed.p2down && pressedLastFrame.p2down);
    keyExit.p2action = (!pressed.p2action && pressedLastFrame.p2action);
    keyExit.enter = (!pressed.enter && pressedLastFrame.enter);
    keyExit.esc = (!pressed.esc && pressedLastFrame.esc);
    keyExit.debug = (!pressed.debug && pressedLastFrame.debug);

    pressedLastFrame.copyPressed(pressed);

  }

  void keyPressed(){
    if(key == 'w') rawInputPressed.p1up = true;
    if(key == 's') rawInputPressed.p1down = true;
    if(key == 'd') rawInputPressed.p1action = true;
    if(keyCode == UP) rawInputPressed.p2up = true;
    if(keyCode == DOWN) rawInputPressed.p2down = true;
    if(keyCode == LEFT) rawInputPressed.p2action = true;
    if(key == ENTER || key == RETURN || key == ' ') rawInputPressed.enter = true;
    if(key == ESC) {
      rawInputPressed.esc = true;
      key = 0;
    }
    if(key == 'p') rawInputPressed.debug = true;
  }

  void keyReleased() {
    if(key == 'w') rawInputPressed.p1up = false;
    if(key == 's') rawInputPressed.p1down = false;
    if(key == 'd') rawInputPressed.p1action = false;
    if(keyCode == UP) rawInputPressed.p2up = false;
    if(keyCode == DOWN) rawInputPressed.p2down = false;
    if(keyCode == LEFT) rawInputPressed.p2action = false;
    if(key == ENTER || key == RETURN || key == ' ') rawInputPressed.enter = false;
    if(key == ESC) {
      rawInputPressed.esc = false;
      key = 0;
    }
    if(key == 'p') rawInputPressed.debug = false;
  }

 void debugDraw(int x, int y) {
    String[] lines = {
      "p1up: " + pressed.p1up,
      "p1down: " + pressed.p1down,
      "p1action: " + pressed.p1action,
      "p2up: " + pressed.p2up,
      "p2down: " + pressed.p2down,
      "p2action: " + pressed.p2action,
      "enter: " + pressed.enter,
      "esc: " + pressed.esc,
      "debug: " + pressed.debug,
    };
    debug.draw(lines, x, y);
  }

}
