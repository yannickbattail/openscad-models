function flatArrayToMatrix(flatArray, nbLine, nbCol) =
  [
    for (y = [0:nbLine - 1])
      [
        for (x = [0:nbCol - 1])
          flatArray[y * nbLine + x]
      ]
  ];

//assert(flatArrayToMatrix([1,2,3, 4,5,6], 2, 3)==[[1,2,3],[3,4,5]]);
