// Made by: Alec, Julia, Shoheet, Josh

Player player = new Player();
PVector cameraPos = new PVector(10,40);

boolean wDown, sDown, aDown, dDown, spaceDown;

void setup(){
  size(800,800);
  rectMode(CENTER);
}

void draw(){
  background(2);
  
  heldKeys();
  playerMove();
  visuals();
}

void visuals(){
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
    cameraPos.y -= 2;
  }
  if(sDown){
    cameraPos.y += 2;
  }
  if(aDown){
    cameraPos.x -= 2;
  }
  if(dDown){
    cameraPos.x += 2;
  }
  if(spaceDown){
    player.boostCharge = constrain(player.boostCharge + 0.015, 0, 1);
  }
}

void keyPressed(){
  if(key == 'w'){
    wDown = true;
  }
  if(key == 's'){
    sDown = true;
  }
  if(key == 'a'){
    aDown = true;
  }
  if(key == 'd'){
    dDown = true;
  }
  if(key == ' '){
    spaceDown = true;
  }
}

void keyReleased(){
  if(key == 'w'){
    wDown = false;
  }
  if(key == 's'){
    sDown = false;
  }
  if(key == 'a'){
    aDown = false;
  }
  if(key == 'd'){
    dDown = false;
  }
  if(key == ' '){
    spaceDown = false;
    player.velocity.x += player.boostCharge * 10 * new PVector(mouseX-cameraPos.x - player.position.x,mouseY-cameraPos.y - player.position.y).normalize().x;
    player.velocity.y += player.boostCharge * 10 * new PVector(mouseX-cameraPos.x - player.position.x,mouseY-cameraPos.y - player.position.y).normalize().y;
    player.boostCharge = 0;
  }
}
