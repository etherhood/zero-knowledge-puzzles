pragma circom 2.1.4;

// In this exercise , we will learn how to check the range of a private variable and prove that 
// it is within the range . 

// For example we can prove that a certain person's income is within the range
// Declare 3 input signals `a`, `lowerbound` and `upperbound`.
// If 'a' is within the range, output 1 , else output 0 using 'out'
include "../node_modules/circomlib/circuits/comparators.circom";

template Range() {
    // your code here
    signal input a;
    signal input lowerbound;
    signal input upperbound;

    signal output out;

	component lessThan = LessEqThan(252);
    lessThan.in[0] <== a;
    lessThan.in[1] <== upperbound;

	component greaterThan = GreaterEqThan(252);
    greaterThan.in[0] <== a;
    greaterThan.in[1] <== lowerbound;

    out <== lessThan.out * greaterThan.out;    
}

component main  = Range();


