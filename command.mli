(* [command] represents a command input by a player.*)
type command =
| Roll
| Buy
| Sell of (string * string * int)
| Quit
| Look of int
| Save of string
| Mortgage of string
| Forfeit
| Invalid
| End
| BuyHouse of string
| SellHouse of string

(* [parse str] is the command that represents player input [str] *)
val parse : string -> command
