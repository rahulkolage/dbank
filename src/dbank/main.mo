// actor {
//   public func greet(name : Text) : async Text {
//     return "Hello, " # name # "!";
//   };
// };

import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// actor === class
// This is also called as Canister
actor DBank {
  // persisted variable using "stable" keyword
  stable var currentValue: Float = 300;
  // currentValue := 300;

  // create constant
  // let id = 342424; // it act as constant
  // Debug.print(debug_show(id));
  // Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  // creating function
  // this is private function, accessible within canister DBank
  // func topUp() {
  //   currentValue  += 1;
  //   Debug.print(debug_show(currentValue));
  // };


  // public function
  // public func topUp(amount: Nat)
  public func topUp(amount: Float) {
    currentValue  += amount;
    Debug.print(debug_show(currentValue));
  };

  // topUp();
  // Candid is way to interact with canisters

  //  Allow users to withdrawl an amount from the currentValue
  // decrease current value by the amount
   // public func withdrawl(amount: Nat) {
  public func withdrawl(amount: Float) {
    let tempValue: Float = currentValue - amount;
  // let tempValue: Int = currentValue - amount;

    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero");
    }
  };

  // Query call to fetch data instead Update
  // query func has Output/Return, then func must have return type of async,
  // output must come out asynchronously 

  // this is read only operation, we are not modifying 
  // public query func checkBalance(): async Nat {
  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNanoSeconds = currentTime - startTime;
    let timeElapsedInSeconds = timeElapsedNanoSeconds / 1000000000;

    // A = currentValue * (1 + 0.01) numSec

    // Bodmas Rule
    // B - Brackets
    // O - Order of powers or roots
    // D - Division
    // M - Multiplication
    // A - Addition
    // S - Subtraction

    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedInSeconds));
    startTime := currentTime;
  };
}