module.exports = {
  //-- [REQUIRED] IPv4 Address of your teamspeak 3 server
  TSServer: "194.147.122.228",

  //-- [REQUIRED] Port of the ws_server
	//-- Make sure you open the port you specify below
  WSServerPort: 10165,

  //-- [OPTIONAL] IPv4 Address of the ws_server
  //-- Set by autoconfig
  // WSServerIP: "127.0.0.1",

  //-- [OPTIONAL] IPv4 Adress of your FiveM server
  //-- Set by autoconfig if you run ws_server as FXServer resource or standalone on the same machine
   FivemServerIP: "54.38.160.34",

  //-- [OPTIONAL] Port of your FiveM Server
  //-- Set by autoconfig if you run ws_server as FXServer resource
  FivemServerPort: 30120,

  //-- [OPTIONAL] Enable connection/disconnection logs
  enableLogs: false,
};
