import Debug "mo:base/Debug";

Debug.print("\n##### 1 #####\n");

let arr : [Nat] = [1, 2, 3, 4, 5];
var sum : Nat = 0;

func arrSum() : Nat {
  for (val in arr.vals()) {
    sum += val;
  };
  return sum;
};

Debug.print(debug_show(arrSum ()));
