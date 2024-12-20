Server server;
Ser ser = new Ser();

class Ser{
  int users;
  String input;
  String output;
}

void serverSetup(){
  server = new Server(this, 12345);
  user.playerNum = 0;
}

void serverEveryFrame(){
  client = server.available();
  if(client != null){
    serverRecieve();
  }
}

void serverRecieve(){
  ser.input = ser.input.substring(0, ser.input.indexOf("\n"));
}

void serverOutput(){
  server.write(ser.output);
}
