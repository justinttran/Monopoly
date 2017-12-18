(* [property] is an abstract type representing a property on the board *)
type property


(* [property_id p] is the id of the property represented by [p] *)
val property_id : property -> string

(* [position_id p] is the index of the property on the board.
 * Requires: [position_id p] is between 0 and 39 inclusive indicating
 * a position on the board. *)
val position_id : property -> int

(* [player_id p] is the id of the player who owns the property
 * represented by [p]. *)
val player_id : property -> string

(* [init_price p] is the initial price that a property [p] sells for
 * specified by the board. *)
val init_price : property -> int

(* [house_price p] is an integer denoting how much money a house
 * (and hotel) costs on that property *)
val house_price : property -> int

(* [rent_prices p] a list of integers, containing the rent prices in
 * order of (0 houses; 1 house; 2 houses; 3 houses; 4 houses; hotel)
 * A hotel will be equivalent to 5 houses. *)
val rent_prices : property -> int list

(* [property_set p] is an int list containing the position id's of
 * the other properties in the set containing property [p] *)
val property_set: property -> int list


(* [num_houses p] is an integer indicating the number of houses on a property *)
val num_houses : property -> int

(* [mortgage_price p] is an integer indicating an integer with the amount of
 * money that a player receives upon mortgaging the property
 * (and the amount of money that player must pay in order to
 * un-mortgage the property) *)
val mortgage_price: property -> int

(* [is_mortgaged p] is a bool indicating whether property [p] is mortgaged *)
val is_mortgaged : property -> bool

(* [change_property_owner p s] takes a property [p] and a player id [s] as
 * inputs and returns a new property with [s] as the new owner *)
val change_property_owner: property -> string -> property

(* [change_is_mortgaged p] takes a property [p] as input and changes
 * returns a new property object with the is_mortgaged property set to
 * false if p.is_mortgaged is true and true if p.is_mortgaged is false *)
val change_is_mortgaged: property -> property

(* [property_from_json j] creates a new property object from parsing a json
 * object corresponding to a property *)
val property_from_json : Yojson.Basic.json -> property

(* [add_house property] adds a house to property if the house count is less than
 * 5 and if the entire set is owned by the player *)
val add_house : property -> property

(* [remove_house property] removes a house from property if the house count of
 * property is greater than 0 *)
val remove_house : property -> property

(* [set_forfeited property] reinitializes a property to have no owner or houses
 * (like it was at the start of the game). This is done to properties that
 * belonged to a player who forfeited, by sending them all back to the bank. *)
val set_forfeited : property -> property
