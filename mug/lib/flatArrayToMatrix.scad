function flatArrayToMatrix(flatArray, nbLine, nbCol) = [
    for (y = [0:nbLine - 1]) [
        for (x = [0:nbCol - 1]) flatArray[y * nbLine + x]
        ]
    ];

echo(flatArrayToMatrix([1, 1,]));