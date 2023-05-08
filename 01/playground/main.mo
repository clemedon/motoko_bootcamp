import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Prelude "mo:base/Prelude";

Debug.print("\n##### 1 #####\n");

func foo() : Text {
  return "Foo";
};

var bar : Nat = 42;

Debug.print(debug_show (foo(), bar));

Debug.print("\n##### 2 #####\n");

let z = do {
  let x = 1;
  let y = x + 1;
  x * y : Nat + x : Int * -1; // unnamed implicit variable
};

Debug.print(debug_show (z));

assert 1 > 0;

if (1 == 0) {
  let swear : Text = Prelude.nyi();
};

Debug.print("\n##### 4 #####\n");

var pair : (Text, Nat) = ("salut" # "ation", 42);
Debug.print(debug_show (pair));

var text = "salut";
text #= "ation";
text := text # " " # pair.0;
Debug.print(debug_show (text));

Debug.print("\n##### 5 #####\n");

var size : Nat = 3;
let arr1 : [var Nat] = Array.init<Nat>(size, 1);
let arr2 : [var Nat] = [var 2, 2, 2];
arr2[0] := 3;

Debug.print(debug_show (arr1, arr2));
