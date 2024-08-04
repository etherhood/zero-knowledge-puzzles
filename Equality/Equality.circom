pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

template IsZero() {

   signal input in;
   signal output out;

   signal inv;

   inv <-- in!=0 ? 1/in : 0;

   out <== -in*inv +1; // this should evaluate to zero in*inv = 1 => - in*inv = -1 
   in*out === 0;
}

template Equality() {
   // Your Code Here..
   signal input a[3];

   signal output c;
   /**
      this way fails because of underflow
      var temp1;
      var temp2;

      temp1 = a[1] - a[2];
      temp2 = a[0] - a[1];

      c <== (1 - temp1) * (1 - temp2);
   */

   component isZero0 = IsZero();
   component isZero1 = IsZero();

   isZero0.in <== a[1] - a[2];
   isZero1.in <== a[0] - a[1];

   c <== isZero0.out * isZero1.out;
}

component main = Equality();