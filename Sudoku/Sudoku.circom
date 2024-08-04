pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";


/*
    Given a 4x4 sudoku board with array signal input "question" and "solution", check if the solution is correct.

    "question" is a 16 length array. Example: [0,4,0,0,0,0,1,0,0,0,0,3,2,0,0,0] == [0, 4, 0, 0]
                                                                                   [0, 0, 1, 0]
                                                                                   [0, 0, 0, 3]
                                                                                   [2, 0, 0, 0]

    "solution" is a 16 length array. Example: [1,4,3,2,3,2,1,4,4,1,2,3,2,3,4,1] == [1, 4, 3, 2]
                                                                                   [3, 2, 1, 4]
                                                                                   [4, 1, 2, 3]
                                                                                   [2, 3, 4, 1]

    "out" is the signal output of the circuit. "out" is 1 if the solution is correct, otherwise 0.                                                                               
*/


template Sudoku () {
    // Question Setup 
    signal input  question[16];
    signal input solution[16];
    signal output out;
    
    // Checking if the question is valid
    for(var v = 0; v < 16; v++){
        log(solution[v],question[v]);
        assert(question[v] == solution[v] || question[v] == 0);
    }
    
    var m = 0 ;
    component row1[4];
    for(var q = 0; q < 4; q++){
        row1[m] = IsEqual();
        row1[m].in[0]  <== question[q];
        row1[m].in[1] <== 0;
        m++;
    }
    3 === row1[3].out + row1[2].out + row1[1].out + row1[0].out;

    m = 0;
    component row2[4];
    for(var q = 4; q < 8; q++){
        row2[m] = IsEqual();
        row2[m].in[0]  <== question[q];
        row2[m].in[1] <== 0;
        m++;
    }
    3 === row2[3].out + row2[2].out + row2[1].out + row2[0].out; 

    m = 0;
    component row3[4];
    for(var q = 8; q < 12; q++){
        row3[m] = IsEqual();
        row3[m].in[0]  <== question[q];
        row3[m].in[1] <== 0;
        m++;
    }
    3 === row3[3].out + row3[2].out + row3[1].out + row3[0].out; 

    m = 0;
    component row4[4];
    for(var q = 12; q < 16; q++){
        row4[m] = IsEqual();
        row4[m].in[0]  <== question[q];
        row4[m].in[1] <== 0;
        m++;
    }
    3 === row4[3].out + row4[2].out + row4[1].out + row4[0].out; 

    // Write your solution from here.. Good Luck!
    component rowResult[4];
    
    for(var i=0; i<4; i++){
        rowResult[i] = IsEqual();
        var sum = solution[4*i] + solution[4*i+1] + solution[4*i+2] + solution[4*i+3];
        rowResult[i].in[0] <== sum;
        rowResult[i].in[1] <== 10;
    }

    component columnResult[4];
    
    for(var i=0; i<4; i++){
        columnResult[i] = IsEqual();
        var sum = solution[i] + solution[i+4] + solution[i+8] + solution[i+12];
        columnResult[i].in[0] <== sum;
        columnResult[i].in[1] <== 10;
    }

    
    component miniSquareResult[4];

    for(var i=0; i < 2; i++){
        miniSquareResult[2*i] = IsEqual();
        var sum = solution[i*8] + solution[8*i+1] + solution[8*i+4] + solution[8*i+4+1];
        miniSquareResult[2*i].in[0] <== sum;
        miniSquareResult[2*i].in[1] <== 10;

        miniSquareResult[2*i+1] = IsEqual();
        sum = solution[8*i + 2] + solution[8*i+3] + solution[8*i+2+4] + solution[8*i+2+4+1];
        miniSquareResult[2*i+1].in[0] <== sum;
        miniSquareResult[2*i+1].in[1] <== 10;
    }

    signal row_01; 
    row_01 <-- rowResult[0].out * rowResult[1].out;
    signal row_23; 
    row_23 <-- rowResult[2].out * rowResult[3].out;

    signal rowValue;
    rowValue <== row_01 * row_23;

    signal column_01; 
    column_01 <-- columnResult[0].out * columnResult[1].out;
    signal column_23; 
    column_23 <-- columnResult[2].out * columnResult[3].out;

    signal columnValue;
    columnValue <== column_01 * column_23;

    signal rowColumn;
    rowColumn <== rowValue*columnValue;

    signal miniSquare_01;
    miniSquare_01 <-- miniSquareResult[0].out * miniSquareResult[1].out;
    signal miniSquare_23;
    miniSquare_23 <-- miniSquareResult[2].out * miniSquareResult[3].out;

    signal squareValue;
    squareValue <== miniSquare_01 * miniSquare_23;

    out <== squareValue * rowColumn;
}


component main = Sudoku();

