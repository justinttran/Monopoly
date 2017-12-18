(* [board] is an abstract type representing the board in a monopoly game. *)
type board

(* [init_board filename i] is the initial board with i players, with no properties
 * owned by any players and all players' wallets containing $1500 *)
val init_board_num : string -> int -> board

(* [init_board filename] is the initial board with the default number of
 * players, with no properties owned by any players and all players' wallets
 * containing $1500 *)
val init_board : string -> board

(* [num_players b] is the number of players in the current board *)
val num_players : board -> int

(*[current_players b] is a list of players on the current board *)
val current_players : board -> Player.player list

(* [turn c b] is [b'] if doing turn [c] in board [b] results
 * in a new board [b']. Else it is [b]. *)
val turn : Command.command -> board -> int -> board

(* [current_space_idx b player_idx] takes a board b and the index of a player
 *  and returns the current position of the player on the board. The
 * current position is an attribute of the player object. The function
 * traverses through the player list in the board object and gets the
 * current space from the player in the correct index. *)
val current_space_idx : board -> int -> int

(* [current_properties b] takes a board object b and returns its properties
 * list *)
val current_properties : board -> Property.property list

(* [buy_house_turn b prop_id i] takes a board [b], property id [id] and
 * player index [i], returns a new board with property list containing
 * a new property containing the new number of houses on the property if the set
 * is comlete and a player list with player object whose wallet has been
 * decreased by the price of a house. *)
val buy_house_turn : board -> string -> int -> board

(* [sell_house_turn b prop_id i] takes a board [b], property id [id] and
 * player index [i], returns a new board with property list containing
 * a new property containing the new number of houses on the property if the set
 * is comlete and a player list with player object whose wallet has been
 * increased by the price of a house. *)
val sell_house_turn : board -> string -> int -> board

(* [is_complete_set b prop_list playername] takes a board [b], property_id list
 * [prop_list] and player name [playername], returns a boolean saying whether
 * the given player owns the entire property sent *)
val is_complete_set : board -> int list -> string -> bool

(* [pay_jail b p_num ] takes a board [b], player_number, returns a new board
 * with the new player out of jail and $50 removed from their wallet *)
val pay_jail : board -> int -> board

(* [get_win_state b ] takes a board [b], returns a tuple with a boolean stating
 * if the board is in a winning state and a list containg the name of the player
 * who won *)
val get_win_state : board -> bool * string list

val is_chance : int -> bool
