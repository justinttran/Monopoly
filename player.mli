open Property
(* [player] is an abstract type representing a player of the game. *)
type player

(* [init_player s i lst] is a player with id s and i dollars*)
val init_player : string -> int -> player

(* [properties p] is the list of property IDs owned by the player *)
val properties : player -> string list

(* [move p rollNum] the player after moving rolllNum number of squres. *)
val move : player -> int -> int -> player

(* [wallet p] is the money in the player's wallet. *)
val wallet : player -> int

(* [in_jail p] is a bool indicating whether a player is in jail *)
val in_jail : player -> bool

(* [buy_property p s] adds the purchased property to the players property
 * list and removes the appropriate money from the players wallet *)
val buy_property: player -> string -> int -> player

(* [sell_property p s] removes the sold property to the players property
 * list and adds appropriate money to the players wallet *)
val sell_property: player -> string -> int -> player


(* [give_money pl money] adds whatever money to the players wallet
 * requires: [money] > 0 *)
val give_money: player -> int -> player

(* [take_money pl money] adds whatever money to the players wallet
 * requires: [money] > 0 and < players wallet *)
val take_money: player -> int -> player

(* [get_name player] is the name string of the player *)
val get_name : player -> string

(* [player_of_json j] is the created from parsing a player json object *)
val player_of_json: Yojson.Basic.json -> player

(* [get_space player] is the index of the current space the player is on *)
val get_space : player -> int

(* [didForfeit player] is the boolean value stating whether the player has
 * forfeited or not *)
val didForfeit : player -> bool

(* [forfeitPlayer player] is the new player after forfeiting, all the players
 * properties are given back to the bank *)
val forfeitPlayer : player -> player

(* [get_out_of_jail player] is the new player after getting out of jail *)
val get_out_of_jail : player -> player

(* [go_to_jail player] is the new player after being sent to jail. Their position
 * is updated to be in jail and the boolean inJail is set to true *)
val go_to_jail : player -> player
