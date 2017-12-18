open OUnit2
open Board
open Player
open Property


let tests =
  [
    "testtest" >:: (fun _ -> assert_equal 1 1);
  ]


let test_player_1 = (Player.init_player ("1") (1500))
let player_tests =
  [
    "nametest" >:: (fun _ -> assert_equal "1" (Player.get_name test_player_1));
    "init_position_test" >:: (fun _ -> assert_equal 0 (Player.get_space test_player_1));
    "movetest" >:: (fun _ -> assert_equal 9 (Player.get_space (Player.move test_player_1 4 5)));
    "movetestover40" >:: (fun _ -> assert_equal 9 (Player.get_space (Player.move test_player_1 44 5)));
    "initpopertiestests" >:: (fun _ -> assert_equal [] (Player.properties (test_player_1)));
    "wallettest" >:: (fun _ -> assert_equal 1500 (Player.wallet test_player_1));
    "take_moneytest" >:: (fun _ -> assert_equal 1000 (Player.wallet (Player.take_money test_player_1 500)));
    "take_moneytest_neg" >:: (fun _ -> assert_equal (-500) (Player.wallet (Player.take_money test_player_1 2000)));
    "give_moneytest" >:: (fun _ -> assert_equal 2000 (Player.wallet (Player.give_money test_player_1 500)));
    "forfeittest" >:: (fun _ -> assert_equal false (Player.didForfeit test_player_1));
    "forfeittestTrue" >:: (fun _ -> assert_equal true (Player.didForfeit (Player.forfeitPlayer test_player_1)));
    "giveandtaketest" >:: (fun _ -> assert_equal 1500 (Player.wallet (Player.give_money (Player.take_money test_player_1 500) 500)));
  ]

let player_with_properties = buy_property test_player_1 "testproperty" 200
let player_property_tests =
  [
    "proplisttest" >:: (fun _ -> assert_equal ["testproperty"] (Player.properties player_with_properties));
    "wallettest" >:: (fun _ -> assert_equal 1300 (Player.wallet player_with_properties));
    "sellproplisttest" >:: (fun _ -> assert_equal [] (Player.properties (sell_property player_with_properties "testproperty" 200)));
    "sellpropwallettest" >:: (fun _ -> assert_equal 1500 (Player.wallet (sell_property player_with_properties "testproperty" 200)));
  ]



let suite =
  "tests"
  >::: List.flatten [
    tests;
    player_tests;
    player_property_tests
  ]
let _ = run_test_tt_main suite
