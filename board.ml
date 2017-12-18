open Property
open Command
open Player
open Yojson.Basic.Util

type board = {
  properties : Property.property list;
  players : Player.player list;
}


(* [num_players b] is the number of players playing the game. It is the length
 *  of the players list in the board object. *)
let num_players b =
  List.length b.players

(* [current_players b] takes a board object b and returns its players list *)
let current_players b =
  b.players

let current_properties b =
  b.properties

let current_space_idx b player_idx =
  let p = List.nth (b.players) player_idx in
  Player.get_space p

(* [get_player_from_id b id] takes a board b and a player id string and returns
 * the player object associated with that player id. *)
let get_player_from_id b id =
  let idx = (int_of_string id) - 1 in
  List.nth (current_players b) idx

(* [restrict_player_list n lst] takes an int [n] and list of players from
 * the JSON and makes the player list has only the specified number of
 * players ([n] elements). *)
let rec restrict_player_list n lst =
  match lst with
  | [] -> failwith "what"
  | h::t -> if n = 1 then [h] else h::(restrict_player_list (n - 1) t)

(* [change_player_list idx new_player players] takes the index of a player,
 * a player object [new_player] and a player list [players],
 * traverses the player list and at the specified index, replaces the
 * player object in the list with [new_player]*)
let change_player_list idx new_player players =
  let rec aux n lst acc =
    match lst with
    | [] -> acc
    | h :: t ->
      if n = idx then
        aux (n + 1) t (new_player :: acc)
      else
        aux (n + 1) t (h :: acc) in
  aux 0 players []

(* [take_tax b pl pos] takes a board [b], player [pl] and board position [pos]
 *  and returns a player object with its wallet attribute subtracted by 200
 *  if the pos is 4 and by 100 if position is 38 (denoting income and luxury
 * tax) *)
let take_tax b pl pos =
  if pos = 4 then
    Player.take_money pl 200
  else if pos = 38 then
    Player.take_money pl 100
  else
    pl

let take_rent b pl pos =
  let prop = List.nth (current_properties b) pos in
  let num_houses = num_houses prop in
  let rent = List.nth (rent_prices prop) num_houses in
  Player.take_money pl rent

let give_rent b pos =
  let prop = List.nth (current_properties b) pos in
  let num_houses = num_houses prop in
  let rent = List.nth (rent_prices prop) num_houses in
  let owner_id = Property.player_id prop in
  let owner_obj = List.nth (current_players b) ((int_of_string owner_id) - 1) in
  Player.give_money owner_obj rent

(* [change_properties_list idx new_property properties] takes the index of
 * a property, a property object [new_player] and a property list [players],
 * traverses the player list and at the specified index, replaces the
 * player object in the list with [new_player]*)
let change_properties_list idx new_property properties =
  let rec aux n lst acc =
    match lst with
    | [] -> List.rev acc
    | h :: t ->
      if n = idx then
        aux (n + 1) t (new_property :: acc)
      else
        aux (n + 1) t (h :: acc) in
  aux 0 properties []

let buy_turn c b i =
  let players = current_players b in
  let player = List.nth players i in
  let position_idx = get_space player in
  let property = List.nth b.properties position_idx in
  if player_id property <> "" then b
  else
    let property_price = init_price property in
    let new_owner = change_property_owner property (get_name player) in
    { players =
        List.rev
          (change_player_list i
             (Player.buy_property player (Property.property_id property)
                (property_price)) players);
      properties =
        (change_properties_list position_idx new_owner b.properties)}

(* [is_real_property id lst] is true if given a a property id [id] and a list
 *  of properties [lst], a property associated with the id is in [lst], and
 * false otherwise. *)
let rec is_real_property id lst =
  match lst with
  | [] -> false
  | h :: t ->
    if String.lowercase_ascii (Property.property_id h) = id then true
    else is_real_property id t

(* [is_real_player id lst] is true if given a a player id [id] and a list
 *  of players [lst], a player associated with the id is in [lst], and
 * false otherwise. *)
let rec is_real_player id lst =
  match lst with
  | [] -> false
  | h :: t ->
    if String.lowercase_ascii (Player.get_name h) = id then true
    else is_real_player id t

(* [get_property_from_id b id lst] takes a board [b], property id [id] and
 * a list of properties [lst] and returns the property associated with the
 * id. *)
let rec get_property_from_id b id lst =
  match lst with
  | [] -> List.hd (current_properties b)
  | h :: t ->
    if String.lowercase_ascii (Property.property_id h) = id &&
       Property.property_id h <> "GO" then h
    else get_property_from_id b id t

(* [sell_turn_helper b prop prop_id seller seller_id buyer buyer_id_str price]
 * returns a board with the sold property given to the new owner, the property
 * removed from the old owner. *)
let sell_turn_helper b prop prop_id seller seller_id buyer buyer_id_str price =
  let is_not_real_owner = player_id prop <> Player.get_name seller in
  let is_not_real_prop = (is_real_property prop_id b.properties) <> true in
  let is_not_real_buyer = (is_real_player buyer_id_str b.players) <> true in
  if is_not_real_owner || is_not_real_prop || is_not_real_buyer then
    b
  else
    let new_owner = Player.buy_property buyer prop_id price in
    let old_owner = Player.sell_property seller prop_id price in
    let buyer_id = int_of_string buyer_id_str - 1 in
    let new_prop = Property.change_property_owner prop
        (string_of_int (buyer_id + 1)) in
    let new_props_list = change_properties_list
        (Property.position_id prop) new_prop (current_properties b) in
    let new_lst1 = List.rev (change_player_list seller_id old_owner b.players) in
    let new_lst2 = List.rev (change_player_list buyer_id new_owner new_lst1) in
    {
      properties = new_props_list;
      players = new_lst2
    }


let sell_turn b prop_id seller_id buyer_id_str price =
  let players = current_players b in
  let buyer = List.nth players (int_of_string buyer_id_str - 1) in
  let seller = List.nth players seller_id in
  let prop = get_property_from_id b prop_id b.properties in
  if Property.property_id prop = "GO" then b else
    sell_turn_helper b prop prop_id seller seller_id buyer buyer_id_str price

(* [mortgage_turn b prop_id i] takes a board [b], property id [id] and
 * player index [i], returns a new board with property list containing
 * a newly mortgaged property (with is_mortgaged set to true) and a
 * player list player object whose wallet has
 * increased by the mortgage price. *)
let mortgage_turn b prop_id i =
  let id_of_declarer = string_of_int (i + 1) in
  let property_lst = b.properties in
  let property = get_property_from_id b prop_id property_lst in
  let player_id = Property.player_id property in
  if player_id <> id_of_declarer then
    b
  else
    let players_lst = b.players in
    let mortgage_price = Property.mortgage_price property in
    let new_prop = Property.change_is_mortgaged property in
    let player = get_player_from_id b player_id in
    let new_player = Player.give_money player mortgage_price in
    let prop_idx = Property.position_id property in
    let player_idx = (int_of_string player_id) - 1 in
    let new_prop_lst = change_properties_list prop_idx new_prop property_lst in
    let new_player_lst = List.rev (change_player_list player_idx new_player players_lst) in
    {
      properties = new_prop_lst;
      players = new_player_lst;
    }

let rec is_complete_set b lst name =
  match lst with
  | [] -> true
  | h::t ->
    let prop = List.nth b.properties h in
    let prop_owner = player_id prop in
    if prop_owner = name
    then is_complete_set b t name
    else false


let buy_house_turn b prop_id i =
  let players = current_players b in
  let player = List.nth players i in
  let property = get_property_from_id b prop_id (current_properties b) in
  if (is_complete_set b (Property.property_set property)
        (Player.get_name player)) then
    let house_count = num_houses property in
    if house_count >= 5
    then
      b
    else
      let new_prop = Property.add_house property in
      let new_props_list = change_properties_list
          (Property.position_id property) new_prop (current_properties b) in
      let new_player = take_money player (house_price property) in
      let new_players_list = List.rev(change_player_list i new_player players) in
      {
        properties = new_props_list;
        players = new_players_list;
      }
  else b

let sell_house_turn b prop_id i =
  let players = current_players b in
  let player = List.nth players (i) in
  let property = get_property_from_id b prop_id (current_properties b) in
  if (Property.player_id property) = (Player.get_name player) then
    let house_count = num_houses property in
    if house_count < 1 then
      b
    else
      let new_prop = Property.remove_house property in
      let new_props_list = change_properties_list
          (Property.position_id property) new_prop (current_properties b) in
      let new_player = give_money player (house_price property) in
      let new_players_list = List.rev(change_player_list i new_player players) in
      {
        properties = new_props_list;
        players = new_players_list;
      }
  else b

let chance_effects b i d1 d2 =
  let p = List.nth (current_players b) i in
  let give_or_take = Random.int 2 in
  let amount = 10 * ((Random.int 10) + 1) in
  if give_or_take = 1 then
    let p' = Player.give_money p amount in
    let p'' = Player.move p' d1 d2 in
    let lst = List.rev (change_player_list i p'' (current_players b)) in
    {b with players = lst}
  else
    let p' = Player.take_money p amount in
    let p'' = Player.move p' d1 d2 in
    let lst = List.rev (change_player_list i p'' (current_players b)) in
    {b with players = lst}

(* [get_player_from_int_id b idx] takes a board b and a player index and returns
 * the player object associated with that index. *)
let get_player_from_int_id b idx =
  List.nth (current_players b) idx

(* [is_chance num] is a boolean indicating whether [num] is in a list
 * containing the positions of the chance cards.*)
let is_chance num =
  (* let curr_pos = Player.get_space player in *)
  let chance_positions = [2;7;17;22;33;36] in
  List.mem num chance_positions

let jail_helper b player_idx =
  let p = (List.nth (current_players b) player_idx) in
  let p' = go_to_jail p in
  let lst = List.rev (change_player_list player_idx p' (current_players b)) in
  { b with players = lst }


(* [roll_turn b i] generates two dice rolls randomly and returns a board
 * with the player on the new position. The player is taxed depending on
 * which position they may land on. *)
let roll_turn b i =
  let players = current_players b in
  let player = List.nth players i in
  let dice1 = Random.int 5 + 1 in
  let dice2 = Random.int 5 + 1 in
  let () = print_endline (string_of_int dice1 ^ " " ^ string_of_int dice2) in
  let new_pos = (Player.get_space player + dice1 + dice2) mod 40 in
  if new_pos = 30 then (jail_helper b i) else
  let taxed_player = take_tax b player new_pos in
  let new_prop = List.nth (current_properties b) new_pos in
  if (is_chance new_pos) then
    chance_effects b i dice1 dice2
  else
  if (player_id new_prop <> "" && player_id new_prop <> "Clarkson"
      && player_id new_prop <> (get_name player) && (is_mortgaged new_prop) = false) then
    let rent_player = take_rent b taxed_player new_pos in
    let rented_player = give_rent b new_pos in
    let new_player = Player.move rent_player dice1 dice2 in
    let new_lst = List.rev (change_player_list i new_player players) in
    let new_lst' = List.rev (change_player_list
                               (int_of_string (get_name rented_player) - 1)
                               rented_player
                               new_lst) in
    {
      properties = b.properties;
      players = new_lst'
    }
  else
  let new_player = Player.move taxed_player dice1 dice2 in
  let new_lst = List.rev (change_player_list i new_player players) in
  {
    b with players = new_lst
  }

let rec remove_player_props props player acc =
  match props with
  | [] -> List.rev acc
  | h::t -> if player_id h = get_name player then
      let orig_prop = set_forfeited h in
      remove_player_props t player (orig_prop :: acc)
    else remove_player_props t player (h::acc)

(* [forfeit_player b i] takes a board [b] and player id [id] and returns a
 * new board object with the didForfeit attribute of player associated
 * the id set to true. The new player is must be replaced within the
 * players. *)
let forfeit_player b i =
  let player = List.nth (current_players b) i in
  let p' = forfeitPlayer player in
  let p_list = List.rev (change_player_list i p' (current_players b)) in
  let props = remove_player_props (current_properties b) player [] in
  {
    players = p_list;
    properties = props
  }

let pay_jail b p_num =
  let player = List.nth (current_players b) p_num in
  let p' = Player.take_money player 50 in
  let p'' = Player.get_out_of_jail p' in
  let p_list = List.rev (change_player_list p_num p'' (current_players b)) in
  {b with players = p_list}

let get_win_state board =
  let players = board.players in
  let rec helper lst still_acctive_players =
    match lst with
    | [] -> ((List.length still_acctive_players = 1), still_acctive_players)
    | h::t ->
      if (Player.didForfeit h)
      then helper t still_acctive_players
      else helper t ((Player.get_name h) :: still_acctive_players)
  in
  helper players []

(* [end_turn b i] takes a board [b] and player index [i] and checks if a
 * player has negative balance after ending the turn. If the player does
 * have negative balance, it returns a board with the player forfeited.
 * Otherwise, it returns a the original board [b]. *)
let end_turn b i =
  let p = List.nth (current_players b) i in
  if wallet p < 0 then forfeit_player b i
  else b

let turn c b i =
  match c with
  | Roll -> roll_turn b i
  | Buy -> buy_turn c b i
  | Sell (str, str', pr) -> sell_turn b str i str' pr
  | BuyHouse str -> buy_house_turn b str i
  | SellHouse str -> sell_house_turn b str i
  | Mortgage str -> mortgage_turn b str i
  | Forfeit -> forfeit_player b i
  | End -> end_turn b i
  | _ -> failwith "Implemented"

let init_board_num filename n =
  let j = Yojson.Basic.from_file filename in
  let playerList = j |> member "players" |> to_list |>
                   List.map (Player.player_of_json) |> restrict_player_list n in
  let propList = j |> member "rooms" |>
                 to_list |>
                 List.map (Property.property_from_json) in
  {
    players = playerList;
    properties = propList;
  }

let init_board filename =
  let j = Yojson.Basic.from_file filename in
  let playerList = j |> member "players" |> to_list |>
                   List.map (Player.player_of_json) in
  let propList = j |> member "rooms" |> to_list |>
                 List.map (Property.property_from_json) in
  {
    players = playerList;
    properties = propList;
  }
