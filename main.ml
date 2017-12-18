open Board
open Player
open Property
open Yojson.Basic.Util
open Command


(* [print_board s] prints an ASCII representation of the monopoly board. It returns
unit. *)
let print_board str =
  let () = print_endline "______________________________________________________________________________________________________________" in
  let () = print_string "|  Jail   | "in
  ANSITerminal.(print_string [magenta] "Rotor 1");
  let () = print_string " |  Free   | " in
  ANSITerminal.(print_string [magenta] "Rotor 2");
  let () = print_string " | " in
  ANSITerminal.(print_string [magenta] "Rotor 3");
  let () = print_string" |  Free   |  " in
  ANSITerminal.(print_string [red] "State");
  let () = print_string"  | CHANCE  | " in
  ANSITerminal.(print_string [red] "Command");
  let () = print_string" |   " in
  ANSITerminal.(print_string [red] "REPL");
  let () = print_string"  |  Free   |\n" in
  let () = print_endline "|  [][]   |  $140   |  ----   |  $140   |  $160   |  ----   |  $180   |  ????   |  $180   |  $200   |  ----   |" in
  let () = print_endline "|  11     |   12    |   13    |   14    |    15   |   16    |   17    |   18    |   19    |   20    |   21    |" in
  let () = print_endline "---------------------------------------------------------------------------------------------------------------" in
  let () = print_string "|  " in
  ANSITerminal.(print_string [green] "Nacci");
  let () = print_string"  |                                                                                         |  " in
  ANSITerminal.(print_string [cyan] "List");
  let () = print_string"   |\n" in
  let () = print_endline "|  $120   |                                                                                         |  $220   |" in
  let () = print_endline "|   10    |                                                                                         |   22    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_string "|  " in
  ANSITerminal.(print_string [green] "Syr");
  let () = print_string"    |                                                                                         | CHANCE  |\n" in
  let () = print_endline "|  100    |                                                                                         |  ----   |" in
  let () = print_endline "|   9     |                                                                                         |   23    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_string "| CHANCE  |                                                                                         |  " in
  ANSITerminal.(print_string [cyan] "Tree");
  let () = print_string "   |\n" in
  let () = print_endline "|  ????   |                                                                                         |  $220   |" in
  let () = print_endline "|   8     |                                                                                         |   24    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_string "| " in
  ANSITerminal.(print_string [green] "Vld_Date");
  let () = print_string"|                                                                                         |  " in
  ANSITerminal.(print_string [cyan] "Engine");
  let () = print_string" |\n" in
  let () = print_endline "|   100   |                                                                                         |   240   |" in
  let () = print_endline "|   7     |                                                                                         |   25    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_endline "|  Free   |                                                                                         |  Free   |" in
  let () = print_endline "|  ----   |                                                                                         |  ----   |" in
  let () = print_endline "|   6     |                                                                                         |   26    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_string "| Inc Tax |                                                                                         |  " in
  ANSITerminal.(print_string [blue] "Eval");
  let () = print_string  "   |\n" in
  let () = print_endline "|  -$200  |                                                                                         |  $260   |" in
  let () = print_endline "|   5     |                                                                                         |   27    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_string "|  " in
  ANSITerminal.(print_string [white; on_green] "Java");
  let () = print_string"   |                                                                                         | " in
  ANSITerminal.(print_string [blue] "Desugar");
  let () = print_string  " |\n" in
  let () = print_endline "|  $60    |                                                                                         |  $260   |" in
  let () = print_endline "|   4     |                                                                                         |   28    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_endline "| CHANCE  |                                                                                         |  Free   |" in
  let () = print_endline "|  ????   |                                                                                         |  ----   |" in
  let () = print_endline "|   3     |                                                                                         |   29    |" in
  let () = print_endline "-----------                                                                                         -----------" in
  let () = print_string "|  " in
  ANSITerminal.(print_string [white; on_green] "Python");
  let () = print_string" |                                                                                         | " in
  ANSITerminal.(print_string [blue] "JoCalf");
  let () = print_string  "  |\n" in
  let () = print_endline "|  $60    |                                                                                         |  $280   |" in
  let () = print_endline "|   2     |                                                                                         |   30    |" in
  let () = print_endline "---------------------------------------------------------------------------------------------------------------" in
  let () = print_string "|  GO     |  " in
  ANSITerminal.(print_string [white; on_black] "OCaml");
  let () = print_string  "  | Lux Tax |   " in
  ANSITerminal.(print_string [white; on_black] "Coq");
  let () = print_string  "   | CHANCE  |  Free   |" in
  ANSITerminal.(print_string [yellow; on_black] "Induction");
  let () = print_string  "| CHANCE  |" in
  ANSITerminal.(print_string [yellow; on_black] "2LstQueue");
  let () = print_string  "|" in
  ANSITerminal.(print_string [yellow; on_black] "SmplQueue");
  let () = print_string  "|  GO TO  |\n" in
  let () = print_endline "| +$200   |  $400   | -$100   |  $350   |  ????   |  ----   |  $320   |  ????   |  $300   |  $300   |  JAIL   |" in
  let () = print_endline "|  1      |   40    |   39    |   38    |   37    |   36    |   35    |   34    |   33    |   32    |   31    |" in
  let () = print_endline "---------------------------------------------------------------------------------------------------------------" in
  ()

(* [get_player_from_num b idx] indexes into the player list and gets the player
objected at index idx. *)
let rec get_player_from_num b idx =
  List.nth (Board.current_players b) idx

(*[get_wallet player_idx b] gets the amount of money that the player with
  index player_idx has at that time.
  requires a valid player_idx.*)
let get_wallet player_idx b =
  let player = List.nth (current_players b) player_idx in
  Player.wallet player

(*[get_wallet player_idx b] gets the position of the player with
  index player_idx.
  requires a valid player_idx.*)
let get_look_str_position player_idx b =
  string_of_int (current_space_idx b player_idx + 1)

(*[get_owner player_idx b] gets the owner of the property on which
  the player with player_idx is standing (the bank, no one, or a player).
  requires a valid player_idx.*)
let get_owner player_idx b =
  let spot_idx = current_space_idx b player_idx in
  let prop = List.nth (Board.current_properties b) spot_idx in
  let id = player_id prop in
  if id = "Clarkson"  then "the bank" else if id = "" then "no one" else "player " ^ id

(*[print_board_players lst b] prints the position of each player (or whether
  they have forfeited) *)
let rec print_board_players lst b =
  match lst with
  | [] -> ()
  | h::t -> let player_num = int_of_string (get_name h) - 1 in
    if Player.didForfeit h then print_endline
        ("  Player " ^ (string_of_int (player_num + 1)) ^ " has forfeited.\n")
    else let () = print_endline
             (" Player " ^ (string_of_int (player_num + 1)) ^
          " is currently at position " ^ (get_look_str_position player_num b) ^ ".\n") in
      print_board_players t b

(*[get_rent_str_helper prices] creates a string of all of the rent prices
  of a property (used to save to JSON) *)
let rec get_rent_str_list_helper prices =
  match prices with
  | [] -> ""
  | h::t -> string_of_int h ^ ", " ^ get_rent_str_list_helper t


(*[get_rent_str prices] cuts off the last comma from the string from
get_rent_str_helper *)
let get_rent_str_list prices =
  let str = get_rent_str_list_helper prices in
  let len = String.length str in
  String.sub str 0 (len - 2)

(*[get_property_set_list_helper prop_nums] creates a string of all the properties
in a set  (used to save to JSON) *)
let rec get_property_set_list_helper prop_nums =
  match prop_nums with
  | [] -> ""
  | h::t -> string_of_int h ^ ", " ^ get_property_set_list_helper t

(*[get_property_set_list prop_nums] cuts off the last comma from the string from
  get_property_set_list_helper *)
let get_property_set_list prop_nums =
  let str = get_property_set_list_helper prop_nums in
  let len = String.length str in
  String.sub str 0 (len - 2)

(*[create_properties_json_list lst] creates a json list of all of the properties
in the current game state, with their appropriate attributes*)
let rec create_properties_json_list lst =
  match lst with
  | [] -> ""
  | h::t -> let id = "\"" ^ property_id h ^ "\"" in
    let position = string_of_int (position_id h) in
    let p_id = "\"" ^ (player_id h) ^ "\"" in
    let price = string_of_int (init_price h) in
    let house_pr = string_of_int (house_price h) in
    let rent_pr = "[" ^ get_rent_str_list (rent_prices h) ^ "]" in
    let property_s = "[" ^ get_property_set_list (property_set h) ^ "]" in
    let num_h = string_of_int (num_houses h) in
    let mortgage_pr = string_of_int (mortgage_price h) in
    let is_mort = string_of_bool (is_mortgaged h) in
    let str = "{\n" ^
              "\"property_id\" : " ^ id ^ ",\n" ^
                "\"position_id\" : " ^ position ^ ",\n" ^
                "\"player_id\" : " ^ p_id ^ ",\n" ^
                "\"init_price\" : " ^ price ^ ",\n" ^
                "\"house_price\" : " ^ house_pr ^ ",\n" ^
                "\"rent_prices\" : " ^ rent_pr ^ ",\n" ^
                "\"property_set\" : " ^ property_s ^ ",\n" ^
                "\"is_mortgaged\" : " ^ is_mort ^ ",\n" ^
                "\"num_houses\" : " ^ num_h ^ ",\n" ^
                "\"mortgage_price\" : " ^ mortgage_pr ^ "\n"
              ^ "},\n"
    in str ^ create_properties_json_list t

(*[get_player_props_str_list_helper prop_strs] creates a string of all the properties
  a player owns  (used to save to JSON) *)
let rec get_player_props_str_list_helper prop_strs =
  match prop_strs with
  | [] -> ""
  | h::t -> "\"" ^  h ^ "\", " ^ get_player_props_str_list_helper t

(*[get_player_props_str_list prop_strs] cuts off the last comma from the string from
  get_player_props_str_list_helper *)
let rec get_player_props_str_list prop_strs =
  let str = get_player_props_str_list_helper prop_strs in
  let len = String.length str in
  if len < 2 then "" else
  String.sub str 0 (len - 2)

(*[create_players_json_list lst] creates a json list of all of the players
  in the current game state, with their appropriate attributes*)
let rec create_players_json_list lst =
  match lst with
  | [] -> ""
  | h::t -> let id = "\"" ^ (get_name h) ^ "\"" in
    let wallet = string_of_int (wallet h) in
    let properties_list = "[" ^ get_player_props_str_list (Player.properties h) ^ "]" in
    let jail = string_of_bool (Player.in_jail h) in
    let position = string_of_int (Player.get_space h) in
    let didForfeit = string_of_bool (Player.didForfeit h) in
    let str = "{\n" ^
              "\"id\" : " ^ id ^ ",\n" ^
                "\"wallet\" : " ^ wallet ^ ",\n" ^
                "\"properties\" : " ^ properties_list ^ ",\n" ^
                "\"inJail\" : " ^ jail ^ ",\n" ^
                "\"position\" : " ^ position ^ ",\n" ^
                "\"didForfeit\" : " ^ didForfeit ^ "\n"
              ^ "},\n"
    in str ^ create_players_json_list t

(* [save_current_board b fname] creates a json_file and writes all of the
   current game data to that file.  Players can then load that game back
into the terminal.*)
let save_current_board b fname =
  let write_out = open_out fname in
  let json_properties_list = create_properties_json_list (current_properties b) in
  let player_json_list = create_players_json_list (current_players b) in
  let json_list' = String.sub json_properties_list 0 (String.length json_properties_list - 2) in
  let player_list' = String.sub player_json_list 0 (String.length player_json_list - 2) in
  let str = "{ \n
            \"rooms\": [ \n" ^ json_list' ^ "], \n
          \"players\" : [ \n" ^ player_list' ^ "\n ] \n }" in
  let () = output_string write_out str in
  flush_all ()

(*[roll_dice i] takes returns a tuple of two random numbers from 1 to 6. Used for
rolls to get out of jail. *)
let roll_dice i =
  let r1 = Random.int 5 + 1 in
  let r2 = Random.int 5 + 1 in
  let () = print_endline (string_of_int r1 ^ ", " ^ string_of_int r2) in
  (Random.int 5 + 1, Random.int 5 + 1)

(*[get_look_str player_idx b] takes in a player index and prints the
  details of that player's state.
requires a valid player index.*)
let get_look_str player_idx b =
("  Player " ^ string_of_int (player_idx + 1) ^ " is at position " ^
 string_of_int ((current_space_idx b player_idx) + 1)) ^ "\n" ^
("  That player has " ^ string_of_int (get_wallet player_idx b) ^ " dollars.\n") ^
("  That player owns " ^ get_player_props_str_list
   (Player.properties (List.nth (current_players b) player_idx)))

(*[get_prop_id p_num b] returns the property id of the property on which
  the player with index p_num is standing.*)
let get_prop_id p_num b =
  let p = List.nth (current_players b) p_num in
  let prop_num = get_space p in
  let prop = List.nth (current_properties b) prop_num in
  property_id prop

(*The main engine of the game, which parses commands and passes them appropriately
to the board module.*)
let rec repl b p_num roll_count =
  let () = print_endline "" in
  let p_num = p_num mod (Board.num_players b) in
  let () = print_endline ("--------") in
  let (did_win, winningplayer) = get_win_state b in
  if (did_win) then print_endline ("GAME OVER! Player "^ List.nth winningplayer 0^ " WON")
  else
  if (didForfeit (List.nth (current_players b) p_num)) then
    let () = print_endline ("Player " ^ (string_of_int (p_num + 1)) ^ " has forfeited.") in
    repl b (p_num + 1) 0
  else if (Player.in_jail (List.nth (current_players b) p_num)) then
    let () = print_endline
        ("You are in jail.  You can try to ROLL doubles,
        or you can PAY $50 to get out immediately.") in
    let str = read_line () in
    if (String.lowercase_ascii str = "roll" && roll_count < 1) then
      let drolls = roll_dice 1 in
      if (fst drolls = snd drolls) then
        let () = print_endline ("You got out of jail!
                              Your turn is now over") in repl b (p_num + 1) 0
      else let () = print_endline
               ("You didn't make it out of jail this time.  Try again next turn.") in repl b (p_num + 1) 0
    else if (String.lowercase_ascii str = "pay") then
      let b' = Board.pay_jail b p_num in
      let () = print_endline ("You paid to get out of jail.") in
      repl b' (p_num + 1) 0
    else let () = print_endline
             ("Invalid command.  Type \"pay\" to get out of jail for $50
              or type \"roll\" to try and roll doubles to get out.") in
      repl b p_num roll_count
  else
  let () = print_endline ("It is currently player " ^ string_of_int (p_num + 1) ^ "'s turn.") in
  let () = print_endline("You are currently on space " ^ get_look_str_position (p_num) b ^ ", " ^ "\"" ^ get_prop_id p_num b ^ "\".") in
  let owned_str = get_owner p_num b in
  let () = print_endline("This space is owned by " ^ owned_str ^ ".") in
  let () = print_endline("You currently have " ^ string_of_int (get_wallet p_num b) ^ " dollars.") in
  let () = print_string ">" in
  let str = read_line () in
  if (String.lowercase_ascii str = "quit") then print_endline("Bye, thanks for playing!") else
  let c = Command.parse str in
  match c with
  | Forfeit -> let b' = Board.turn c b p_num in repl b' (p_num + 1) 0
  | Save filename -> if (String.length filename < 6 ||
                         String.sub filename (String.length filename - 5) 5 <> ".json")
    then let fname = filename ^ ".json" in let () = save_current_board b fname in print_endline ("Game saved to " ^ fname ^".  Goodbye!")
    else
    let () = save_current_board b filename in print_endline ("Game saved to " ^ filename ^".  Goodbye!")
  | Roll -> if (roll_count > 0) then
      let () = print_endline ("You have already rolled this turn.  Try something else")
      in repl b p_num roll_count else
      let b' = Board.turn c b p_num in
      let () = print_endline("You are currently on space " ^ get_look_str_position (p_num) b' ^ ", \"" ^ get_prop_id p_num b' ^ "\".") in
      if (is_chance (get_space (List.nth (current_players b') p_num))) then
        let () = print_endline ("You landed on a chance space!") in
        let old_wallet = Player.wallet (List.nth (current_players b) p_num) in
        let new_wallet = Player.wallet (List.nth (current_players b') p_num) in
        if (old_wallet > new_wallet) then let () = print_endline ("You lost " ^ string_of_int (old_wallet - new_wallet) ^ " dollars.") in
          repl b' (p_num) (roll_count + 1)
        else let () = print_endline ("You gained " ^ string_of_int (new_wallet - old_wallet) ^ " dollars!") in
          repl b' (p_num) (roll_count + 1)
      else repl b' (p_num) (roll_count + 1)
  | Look i -> if i = 5 then let () = print_board "" in
      let () = (print_board_players (current_players b) b)
      in repl b p_num roll_count
    else if i < 0 || i > Board.num_players b - 1 then
      let () = print_endline "Invalid player" in repl b p_num roll_count else
    let () = print_endline (get_look_str i b) in repl b p_num roll_count
  | Buy -> let b' = Board.turn c b p_num in
    if b = b' then
      let () = print_endline "You cannot buy this space." in repl b p_num roll_count
      else
        let () = print_endline "Property successfully purchased!" in
        repl b' (p_num) roll_count
  | Sell (str, str', i)-> let b' = Board.turn c b p_num in
    if b = b' then let () = print_endline "Sell failed." in repl b p_num roll_count else
      let () = print_endline "Property successfully sold!" in
      repl b' (p_num) roll_count
  | End -> if roll_count = 0 then let () = print_endline ("Cannot end - you must roll on each turn.") in
      repl b p_num 0 else
    let b' = Board.turn c b p_num in
    repl b' (p_num + 1) 0
  | Mortgage str -> let b' = Board.turn c b p_num in
    if b = b' then let () = print_endline ("Mortgage failed.") in repl b p_num roll_count else
      let () = print_endline ("Property successfully mortgaged!") in
      repl b' (p_num) roll_count
  | BuyHouse str -> let b' = Board.turn c b p_num in
    if b = b' then let () = print_endline ("Failed to buy a house.") in repl b p_num roll_count
    else repl b' p_num roll_count
  | SellHouse str -> let b' = Board.turn c b p_num in
    if b = b' then let () = print_endline ("Failed to sell a house.") in repl b p_num roll_count
    else repl b' p_num roll_count
  | Invalid ->
    let () = print_endline("Invalid command try again.
      Valid commands are:
      Roll
      Buy (to buy a property that you are on)
      Buyhouse property_name (to buy a house on a property that you own)
      Sellhouse property_name (to sell a house on a property that you own)
      Sell (propertyName, playerID, price)
      Quit
      Look playerNumber
      Save fileName
      Mortage propertyName
      Forfeit\n")
    in repl b p_num roll_count
  | _ -> failwith "implemented"

(*Ensures that the file from which a player is trying to load their
game is a json file. *)
let check_valid_file f =
  try let j = Yojson.Basic.from_file f in if j = j then true else false
  with  _ -> false

let rec play_game f =
  if f = "" then let () = print_endline "How many players do you want in the game? (2 - 4)" in
    let () = print_string ">" in
    let s = read_line() in
    try let i = int_of_string s in
      if (i<2 || i>4) then
        let () = print_endline "INVALID NUMBER. Enter number between 2-4" in
        play_game ""
      else
        let b = Board.init_board_num "properties.json" i in repl b 0 0
    with Failure _ -> let () = print_endline "INVALID NUMBER. Enter number between 2-4"
      in play_game ""
  else
  if (String.length f >= 6 && (String.sub f ((String.length f) - 5) 5) <> ".json") then
    let f' = f ^ ".json" in
    if check_valid_file f' then
      try let b = Board.init_board f' in repl b 0 0
      with _ -> let () = print_endline "Invalid JSON game file.  Defaulting to original board." in play_game ""
    else main ()
  else if check_valid_file f then
    try let b = Board.init_board f in repl b 0 0
    with _ -> let () = print_endline "Invalid JSON game file.  Defaulting to original board." in play_game ""
  else main ()

and main () =
  let () = Random.self_init () in
  ANSITerminal.(print_string [red]
    "\n\nCLARKSON-OPOLY\n");
  print_endline "Enter the name of the json from which you would like to load you game (or enter nothing for basic board).\n";
  print_string  "> ";
  match read_line () with
  | "" -> play_game ""
  | exception End_of_file -> ()
  | file_name -> play_game file_name

let () = main ()
