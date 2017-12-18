open Property
open Yojson.Basic.Util

type player = {
  name: string;
  wallet: int;
  propertieslist: string list;
  inJail: bool;
  position: int;
  didForfeit: bool;
}


let init_player id startMoney = {
  name = id;
  wallet = startMoney;
  propertieslist = [];
  inJail = false;
  position = 0;
  didForfeit = false;
}

let player_of_json j =
 {
    name = j |> member "id" |> to_string;
    wallet = j |> member "wallet" |> to_int;
    propertieslist = j |> member "properties" |> to_list |> List.map to_string;
    inJail = j |> member "inJail" |> to_bool;
    position = j |> member "position" |> to_int;
    didForfeit = j |> member "didForfeit" |> to_bool
  }

let get_name p =
  p.name

let get_space p =
  p.position


let move player roll1 roll2 =
  if player.inJail && (roll1 <> roll2)
  then
    player
  else
    if (player.position + roll1 + roll2 > 39)
    then
      {
        name = player.name;
        wallet = player.wallet + 200;
        propertieslist = player.propertieslist;
        inJail = player.inJail;
        position = (player.position + roll1 + roll2) mod 40;
        didForfeit = player.didForfeit;
      }
    else
      {
        name = player.name;
        wallet = player.wallet;
        propertieslist = player.propertieslist;
        inJail = player.inJail;
        position = (player.position + roll1 + roll2) mod 40;
        didForfeit = player.didForfeit;
      }

let properties p =
  p.propertieslist

let wallet p =
  p.wallet

let in_jail p =
  p.inJail

let go_to_jail player =
  {
    name = player.name;
    wallet = player.wallet;
    propertieslist = player.propertieslist;
    inJail = true;
    position = 10;
    didForfeit = player.didForfeit;
  }

let get_out_of_jail player =
  {
    name = player.name;
    wallet = player.wallet;
    propertieslist = player.propertieslist;
    inJail = false;
    position = player.position;
    didForfeit = player.didForfeit;
  }

let buy_property pl propName propPrice =
  {
    name = pl.name;
    wallet = pl.wallet - (propPrice);
    propertieslist = (propName) :: pl.propertieslist;
    inJail = pl.inJail;
    position = pl.position;
    didForfeit = pl.didForfeit;
  }

(* [removeProperty proplist propid acc] helper funtion for sell_property that
 * takes a list of property ids and removes the desired property id from the list. *)
let rec removeProperty proplist propid acc=
  match proplist with
  | [] -> acc
  | h::t ->
    if h = propid
    then removeProperty t propid acc
    else removeProperty t propid (h::acc)

let sell_property pl propName propPrice =
  let proplist = pl.propertieslist in
  let newPropList = removeProperty proplist propName [] in
  let newWallet = pl.wallet + propPrice in
  {
    name = pl.name;
    wallet = newWallet;
    propertieslist = newPropList;
    inJail = pl.inJail;
    position = pl.position;
    didForfeit = pl.didForfeit;
  }

let give_money pl money =
  {
    name = pl.name;
    wallet = pl.wallet + money;
    propertieslist = pl.propertieslist;
    inJail = pl.inJail;
    position = pl.position;
    didForfeit = pl.didForfeit;
  }

let take_money pl money =
  {
    name = pl.name;
    wallet = pl.wallet - money;
    propertieslist = pl.propertieslist;
    inJail = pl.inJail;
    position = pl.position;
    didForfeit = pl.didForfeit;
  }

let didForfeit player =
  player.didForfeit

let forfeitPlayer player =
  {
    name = player.name;
    wallet = player.wallet;
    propertieslist = player.propertieslist;
    inJail = player.inJail;
    position = player.position;
    didForfeit = true;
  }
