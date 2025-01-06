// Made by: Alec, Julia, Shoheet, Josh

PImage AssassinImg;
PImage CyclopsImg;
PImage SoldierImg;
PImage KnightImg;
PImage WinAssassinImg;
PImage WinCyclopsImg;
PImage WinSoldierImg;
PImage WinKnightImg;
PImage arenaImg;
PImage titleScreenImg;

Player player = new Player();
ArrayList<Player> players = new ArrayList();
PVector cameraPos = new PVector(10,40);

// 0 = main menu, 1 = game, 2 = win, 3 = skin select
int menu = 0;
boolean wDown, aDown, dDown, spaceDown, upDown, leftDown, rightDown;

void setup(){
  size(800,800);
  rectMode(CENTER);
  AssassinImg = loadImage("Assassin.png");
  CyclopsImg = loadImage("Cyclops.png");
  SoldierImg = loadImage("Soldier.png");
  KnightImg = loadImage("Knight.png");
  WinAssassinImg = loadImage("WinAssassin.png");
  WinCyclopsImg = loadImage("WinCyclops.png");
  WinSoldierImg = loadImage("WinSoldier.png");
  WinKnightImg = loadImage("WinKnight.png");
  arenaImg = loadImage("arena.png");
  titleScreenImg = loadImage("titleScreen.png");
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
      ellipse(player.position.x,player.position.y,40,40);
      strokeWeight(5);
      stroke(255);
      if(spaceDown){
        line(player.position.x,player.position.y,player.position.x + player.boostCharge * 100 * new PVector(mouseX-cameraPos.x - player.position.x,mouseY-cameraPos.y - player.position.y).normalize().x, player.position.y + player.boostCharge * 100 * new PVector(mouseX-cameraPos.x - player.position.x,mouseY-cameraPos.y - player.position.y).normalize().y);
      }
      pop();
      break;
    case 2:
    
      break;
    case 3:
    
      break;
  }
}

void playerMove(){
  player.velocity.x += player.acceleration.x;
  player.velocity.y += player.acceleration.y;
  player.position.x += player.velocity.x;
  player.position.y += player.velocity.y;
  // slowly going towards 0
  player.velocity.x *= 0.98;
  player.velocity.y *= 0.98;
}

void heldKeys(){
  if(wDown){
    players.get(0).boostCharge = constrain(player.boostCharge + 0.015, 0, 1);
  }
  if(aDown){
    players.get(0).rotation -= 1;
  }
  if(dDown){
    players.get(0).rotation += 1;
  }
  if(upDown){
    players.get(1).boostCharge = constrain(player.boostCharge + 0.015, 0, 1);
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
  }
  if(key == 'd'){
    dDown = true;
  }
  if(key == UP){
    upDown = true;
  }
  if(key == LEFT){
    leftDown = true;
  }
  if(key == RIGHT){
    rightDown = true;
  }
  if(key == ' '){
    spaceDown = true;
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
    player.boostCharge = 0;
  }
}
