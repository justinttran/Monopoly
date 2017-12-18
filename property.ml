open Yojson.Basic.Util

type property =
  {
    property_id : string;
    position_id : int;
    player_id : string;
    init_price : int;
    house_price : int;
    rent_prices : int list;
    property_set : int list;
    num_houses : int;
    mortgage_price : int;
    is_mortgaged : bool;
  }

let property_from_json j = {
  property_id = j |> member "property_id" |> to_string;
  position_id = j |> member "position_id" |> to_int;
  player_id = j |> member "player_id" |> to_string;
  init_price = j |> member "init_price" |> to_int;
  house_price = j |> member "house_price" |> to_int;
  rent_prices = j |> member "rent_prices" |> to_list |> List.map to_int;
  property_set = j |> member "property_set" |> to_list |> List.map to_int;
  num_houses = j |> member "num_houses" |> to_int;
  mortgage_price = j |> member "mortgage_price" |> to_int;
  is_mortgaged = j |> member "is_mortgaged" |> to_bool;
}

let property_id p =
  p.property_id

let position_id p =
  p.position_id

let player_id p =
  p.player_id

let init_price p =
  p.init_price

let house_price p =
  p.house_price

let add_house p =
  if p.num_houses >= 5
  then p
  else
    {
      property_id = p.property_id;
      position_id = p.position_id;
      player_id = p.player_id;
      init_price = p.init_price;
      house_price = p.house_price;
      rent_prices = p.rent_prices;
      property_set = p.property_set;
      num_houses = p.num_houses + 1;
      mortgage_price = p.mortgage_price;
      is_mortgaged = p.is_mortgaged;
    }

let remove_house p =
  if p.num_houses <= 0
  then p
  else
    {
      property_id = p.property_id;
      position_id = p.position_id;
      player_id = p.player_id;
      init_price = p.init_price;
      house_price = p.house_price;
      rent_prices = p.rent_prices;
      property_set = p.property_set;
      num_houses = p.num_houses - 1;
      mortgage_price = p.mortgage_price;
      is_mortgaged = p.is_mortgaged;
    }



let rent_prices p =
  p.rent_prices

let property_set p =
  p.property_set

let num_houses p =
  p.num_houses

let mortgage_price p =
  p.mortgage_price

let is_mortgaged p =
  p.is_mortgaged

let change_property_owner p player_id =
  {p with player_id = player_id}

let change_is_mortgaged p =
  match p.is_mortgaged with
  | true -> {p with is_mortgaged = false}
  | false -> {p with is_mortgaged = true}

let set_forfeited p =
  {
    property_id = p.property_id;
    position_id = p.position_id;
    player_id = "";
    init_price = p.init_price;
    house_price = p.house_price;
    rent_prices = p.rent_prices;
    property_set = p.property_set;
    num_houses = 0;
    mortgage_price = p.mortgage_price;
    is_mortgaged = false;
  }
