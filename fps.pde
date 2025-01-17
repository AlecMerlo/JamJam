// Made by: Alec, Julia, Shoheet, Josh

PImage AssassinImg;
PImage CyborgImg;
PImage SoldierImg;
PImage KnightImg;
PImage WinAssassinImg;
PImage WinCyborgImg;
PImage WinSoldierImg;
PImage WinKnightImg;
PImage arenaImg;
PImage titleScreenImg;
int playerSkin = 0;

Player player1 = new Player();
Player player2 = new Player();
ArrayList<Player> players = new ArrayList();
PVector cameraPos = new PVector(10,40);

// 0 = main menu, 1 = game, 2 = win, 3 = skin select
int menu = 0;
boolean wDown, aDown, dDown, spaceDown, upDown, leftDown, rightDown;

void setup(){
  size(800,800);
  rectMode(CENTER);
  AssassinImg = loadImage("Assassin.png");
  CyborgImg = loadImage("Cyborg.png");
  SoldierImg = loadImage("Soldier.png");
  KnightImg = loadImage("Knight.png");
  WinAssassinImg = loadImage("WinAssassin.png");
  WinCyborgImg = loadImage("WinCyborg.png");
  WinSoldierImg = loadImage("WinSoldier.png");
  WinKnightImg = loadImage("WinKnight.png");
  arenaImg = loadImage("arena.png");
  titleScreenImg = loadImage("titleScreen.png");
  players.add(player1);
  players.add(player2);
}

void draw(){
  background(2);
  
  heldKeys();
  playerMove();
  visuals();
}

void visuals(){
  imageMode(CENTER);
  switch(menu){
    case 0:
      image(titleScreenImg, 400,400,800,800);
      break;
    case 1:
      // moving everything to the camera position
      push();
      translate(cameraPos.x, cameraPos.y);
      ellipse(players.get(0).position.x,players.get(0).position.y,40,40);
      strokeWeight(5);
      stroke(255);
      if(spaceDown){
        line(players.get(0).position.x,players.get(0).position.y,players.get(0).position.x + players.get(0).boostCharge * 100 * new PVector(mouseX-cameraPos.x - players.get(0).position.x,mouseY-cameraPos.y - players.get(0).position.y).normalize().x, players.get(0).position.y + players.get(0).boostCharge * 100 * new PVector(mouseX-cameraPos.x - players.get(0).position.x,mouseY-cameraPos.y - players.get(0).position.y).normalize().y);
      }
      pop();
      break;
    case 2:
    
      break;
    case 3:
    //player 1
    if (players.get(0).skin == 0) {
      image(AssassinImg, 200, 400, 300, 300);
    } else if (players.get(0).skin == 1) {
    image(CyborgImg, 200, 400, 300, 300);
    } else if (players.get(0).skin == 2) {
    image(SoldierImg, 200, 400, 300, 300);
    } else if (players.get(0).skin == 3) {
    image(KnightImg, 200, 400, 300, 300);
    }
    //player 2
    if (players.get(1).skin == 0) {
      image(AssassinImg, 600, 400, 300, 300);
    } else if (players.get(1).skin == 1) {
    image(CyborgImg, 600, 400, 300, 300);
    } else if (players.get(1).skin == 2) {
    image(SoldierImg, 600, 400, 300, 300);
    } else if (players.get(1).skin == 3) {
    image(KnightImg, 600, 400, 300, 300);
    }
      break;
  }
}

void playerMove(){
  players.get(0).velocity.x += players.get(0).acceleration.x;
  players.get(0).velocity.y += players.get(0).acceleration.y;
  players.get(0).position.x += players.get(0).velocity.x;
  players.get(0).position.y += players.get(0).velocity.y;
  // slowly going towards 0
  players.get(0).velocity.x *= 0.98;
  players.get(0).velocity.y *= 0.98;
}

void heldKeys(){
  if(wDown){
    players.get(0).boostCharge = constrain(players.get(0).boostCharge + 0.015, 0, 1);
  }
  if(aDown){
    players.get(0).rotation -= 1;
  }
  if(dDown){
    players.get(0).rotation += 1;
  }
  if(upDown){
    players.get(1).boostCharge = constrain(players.get(0).boostCharge + 0.015, 0, 1);
  }
  if(leftDown){
    players.get(1).rotation -= 1;
  }
  if(rightDown){
    players.get(1).rotation += 1;
  }
}

void keyPressed(){
  if(key == 'w'){
    wDown = true;
  }
  if(key == 'a'){
    aDown = true;
    if (menu == 3) {
    players.get(0).skin += 1;
      if (players.get(0).skin == 4) {
        players.get(0).skin = 0;
      }
    }
  } 
  if(key == 'd'){
    dDown = true;
    if (menu == 3) {
    players.get(0).skin -= 1;
      if (players.get(0).skin == -1) {
        players.get(0).skin = 3;
      }
    }
  }
  if(keyCode == UP){
    upDown = true;
  }
  if(keyCode == LEFT){
    leftDown = true;
    if (menu == 3) {
    players.get(1).skin += 1;
      if (players.get(1).skin == 4) {
        players.get(1).skin = 0;
      }
    }
  }
  if(keyCode == RIGHT){
    rightDown = true;
    if (menu == 3) {
    players.get(1).skin -= 1;
      if (players.get(1).skin == -1) {
        players.get(1).skin = 3;
      }
    }
  }
  if(key == ' '){
    spaceDown = true;
  }
  if(key == '\n'){
    if(menu == 0){
      menu = 3;
    }
  }
}

void keyReleased(){
  if(key == 'w'){
    wDown = false;
  }
  if(key == 'a'){
    aDown = false;
  }
  if(key == 'd'){
    dDown = false;
  }
  if(key == UP){
    upDown = false;
  }
  if(key == LEFT){
    leftDown = false;
  }
  if(key == RIGHT){
    rightDown = false;
  }
  if(key == ' '){
    spaceDown = false;
    players.get(0).velocity.x += players.get(0).boostCharge * 10 * new PVector(mouseX-cameraPos.x - players.get(0).position.x,mouseY-cameraPos.y - players.get(0).position.y).normalize().x;
    players.get(0).velocity.y += players.get(0).boostCharge * 10 * new PVector(mouseX-cameraPos.x - players.get(0).position.x,mouseY-cameraPos.y - players.get(0).position.y).normalize().y;
    players.get(0).boostCharge = 0;
  }
}
