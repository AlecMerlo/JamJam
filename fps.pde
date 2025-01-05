// Made by: Alec, Julia, Shoheet, Josh

import processing.net.*;

Server ser;
Client cli;

Player player = new Player();
PVector cameraPos = new PVector(10,40);

boolean wDown, sDown, aDown, dDown, spaceDown;
boolean isServer = false;
boolean cliConnected = false;

// 0 = menu,  1 = game, 2 = server menu, 3 = client menu
int screen = 0;

String userInput = "";

void setup(){
  size(800,800);
  rectMode(CENTER);
}

void draw(){
  background(2);
  
  heldKeys();
  if(screen == 1){
    playerMove();
    if(cliConnected == true){
      client();
    }
    else if(isServer == true){
      server();
    }
  }
  visuals();
}

void client(){
  cli.write(player.position.toString());
}

void server(){
  cli = ser.available();
  if(cli != null){
    String input = "";
    input = cli.readString();
    //input = input.substring(0, input.indexOf('\n')); // Only up to the newline
    println(input);
  }
}

void connect(){
  cli = new Client(this, userInput, 12345);
  if((cli = new Client(this, userInput, 12345)) != null){
    screen = 3;
    cliConnected = true;
  }
  else{
    screen = 0;
  }
}

void startGame(){
  if(isServer){
    screen = 1;
  }
  else if(userInput == ""){
    ser = new Server(this,12345);
    isServer = true;
    screen = 2;
  }
  else{
    connect();
  }
}

void visuals(){
  if(screen == 0){
    text("Enter no text to be a server, enter the other person's ip to join them",200,200);
    text(userInput,200,250);
  }
  if(screen == 1){
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
  if(screen == 2){
    text("You are a server, your ip is: "+ser.ip(),200,200);
  }
  if(screen == 3){
    
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
  /*if(wDown){
    cameraPos.y += 2;
  }
  if(sDown){
    cameraPos.y -= 2;
  }
  if(aDown){
    cameraPos.x += 2;
  }
  if(dDown){
    cameraPos.x -= 2;
  }*/
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
    if(screen == 1){
      player.velocity.x += player.boostCharge * 10 * new PVector(mouseX-cameraPos.x - player.position.x,mouseY-cameraPos.y - player.position.y).normalize().x;
      player.velocity.y += player.boostCharge * 10 * new PVector(mouseX-cameraPos.x - player.position.x,mouseY-cameraPos.y - player.position.y).normalize().y;
      player.boostCharge = 0;
    }
  }
  if(key == '\n'){
    if(screen == 0 || screen == 2){
      startGame();
    }
    if(screen == 3){
      if(cli.active() == true){
        screen = 1;
      }
      else{
        screen = 0;
      }
    }
    userInput = "";
  }
  if(keyCode == BACKSPACE){
    userInput = "";
  }
  if((key >= 48 && key <= 57) || key == '.'){
    userInput += key;
  }
}
