import Debug "mo:base/Debug";

Debug.print( "\n##### 1 #####\n" );
func foo() : Text {
  return "Foo";
};

var bar : Nat = 42;

Debug.print( debug_show( foo(), bar ) );

Debug.print( "\n##### 2 #####\n" );
let z = do {
  let x = 1;
  let y = x + 1;
  x*  y : Nat + x : Int * -1;  // unnamed implicit variable
};

Debug.print( debug_show( z ) );

Debug.print( "\n##### 3 #####\n" );

let swear : Text = nyi();
