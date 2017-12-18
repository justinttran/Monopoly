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


(* [split_on_space str] returns the tuple containing the section of the original
   string up until the first ' ' as str1 and the rest of the string as str2 in
   (str1,str2)
*)
let split_on_space str =
  let split_index = String.index str ' ' in
  let str1 = String.sub str 0 split_index in
  let str2 = String.sub str (split_index+1) ((String.length str)- (split_index+1)) in
  (str1, str2)

(* [parse str] is the command that represents player input [str].
 * requires: [str] is one of the commands forms described in the
 *   assignment writeup. *)
let parse str =
  try
  let new_str = String.trim(String.lowercase_ascii str) in
  if (String.contains str ' ')
  then
    let (str1, str2) = split_on_space new_str in
    if str1 = "sell"
    then
      let (newstr2, str3) = split_on_space str2 in
      if newstr2 = "house"
      then
        SellHouse str3
      else
        let (newstr3, intStr) = split_on_space str3 in
        try let intStr' = int_of_string intStr in
          Sell (newstr2, newstr3, intStr')
        with Failure _ -> Invalid
    else
      match str1 with
      | "save" -> Save str2
      | "mortgage" -> Mortgage str2
      | "buyhouse" -> BuyHouse str2
      | "sellhouse" -> SellHouse str2
      | "look" ->
          let lookInt = try
            (int_of_string str2 -1)
          with
          |_ -> 5 in
        Look lookInt

      | _ -> Invalid
  else
    match new_str with
    | "quit" -> Quit
    | "roll" -> Roll
    | "buy" -> Buy
    | "forfeit" -> Forfeit
    | "end" -> End
    | _ -> Invalid
  with _ -> Invalid
