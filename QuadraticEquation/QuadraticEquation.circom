pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a Quadratic Equation( ax^2 + bx + c ) verifier using the below data.
// Use comparators.circom lib to compare results if equal

template QuadraticEquation() {
    signal input x;     // x value
    signal input a;     // coeffecient of x^2
    signal input b;     // coeffecient of x 
    signal input c;     // constant c in equation
    signal input res;   // Expected result of the equation
    signal output out;  // If res is correct , then return 1 , else 0 . 

    signal x_squared <== x*x;

    signal first_term <== a*x_squared;

    signal second_term <== b*x;

    component isEqual = IsEqual();

    isEqual.in[0] <== first_term + second_term + c;
    isEqual.in[1] <== res;

    out <== isEqual.out;
    // your code here
}

component main  = QuadraticEquation();



