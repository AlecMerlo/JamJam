Server server;

class Ser{
  int port;
}

void serverSetup(){
  Ser ser = new Ser();
  ser.port = int(random(10000,99999));
  server = new Server(this, ser.port);
  user.playerNum = 0;
}

void serverEveryFrame(){
  client = server.available();
  if(client != null){
    
  }
}

void serverRecieve(){
  
}

void serverOutput(){
  
}
