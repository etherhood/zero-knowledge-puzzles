pragma circom 2.1.4;

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 

function square(num) {
   return num*num;
}

template Pow() {
   signal input a[2];
   signal output c;

   var prevValue;
   var result;
   result = 1;

   for(var i=0; i<256; i++){
      var isIncluded = (a[1] >> i) & 1;
      var expValue;
      if(i == 0){
         expValue = a[0];
      } else {
         expValue = square(prevValue);            
      }

      if(isIncluded == 1){
         result = result * expValue;
      }

      prevValue = expValue;
   }
   
   signal intermediate;
   intermediate <-- result;

   c <== intermediate;
}

component main = Pow();