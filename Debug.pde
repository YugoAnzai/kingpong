class Debug {

  void draw(String[] lines, int x, int y){

    color boardColor = color(0);
    color textColor = color(255);

    draw(lines, x, y, boardColor, textColor);

  }

  void draw(String[] lines, int x, int y, color boardColor, color textColor) {

    int lineHeight = 10;
    int charWidth = 8;
    int textSize = 16;

    int longest = 0;
    for (int i = 0; i < lines.length; i++){
      if (lines[i].length() > longest){
        longest = lines[i]. length();
      }
    }

    noStroke();
    fill(boardColor);
    int boardWidth = longest * charWidth;
    int boardHeight = lines.length * lineHeight;
    rect(x + boardWidth/2, y + boardHeight/2, boardWidth, boardHeight);
    fill(textColor);
    textSize(12);
    textAlign(LEFT);
    for (int i = 0; i < lines.length; i++){
      text(lines[i], x, y + (i + 1) * lineHeight);
    }
    textAlign(CENTER);
  }

}
