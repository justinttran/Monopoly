This project assumes that OCaml and OPAM are installed and working (OCaml 4.05.0 and OPAM 1.2.2).

In the directory with all of the source files, type “make play” to compile and run the game.

The game will then prompt you to load a valid JSON file containing the properties and players.

You can just press enter if you don't have a JSON to load. 

You may input a the name of the JSON file with or without the .json extension.

A valid json file has a:
  Properties list that has the following format:

  "rooms": [
  {
  "property_id" : "GO",
  "position_id" : 0,
  "player_id" : "Clarkson",
  "init_price" : -1,
  "house_price" : -1,
  "rent_prices" : [0, 0, 0, 0, 0, 0],
  "property_set" : [0, 0, 0],
  "is_mortgaged" : false,
  "num_houses" : -1,
  "mortgage_price" : -1
  },
  ]

  Players list that has the following format
  "players" : [
  {
  "id" : "1",
  "wallet" : 1,
  "properties" : ["vld_date"],
  "inJail" : false,
  "position" : 25,
  "didForfeit" : false
  },
  ]



The following commands are supported by the game, which follows the rules of Monopoly (except for the rarely-used rule that properties not bought upon landing are auctioned to the rest of the players):

Roll - if the player is not in jail, this command rolls two dice and moves the player that many spaces forwards.  If the player is in jail, they must roll doubles in order to escape.

Buy - buys the property on which the player is currently standing.  Only works if the property is unowned by the players and the bank (spaces like “GO” and “Free Parking”).

Quit - quits the game without saving.

Look - can be “used’ on a player (e.g. “look 1”) or on the board in order to print the board (“look board”).

Save - saves the current state of the game to a .json file.  Appends “.json” if the player only types the name of the file itself.

Mortgage - mortgages the property specified by the command “mortgage *property*”

Forfeit - removes the player from that game.  If all players except one have forfeited, that player wins the game.

End - ends a player’s turn.  If that player has negative money at the end of his or turn, that player forfeits the game.

BuyHouse - buys a house on the property specified.

SellHouse - sells a house on the property specified.
