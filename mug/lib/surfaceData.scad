// source https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks
// operate like the builtin module surface() but
// from a matrix of floats instead of a text file
function surfaceDataf(M, center = false) = let(
    n = len(M),
    m = len(M[0]),
    miz = min([for (Mi = M) min(Mi)]),
    minz = miz < 0? miz - 1 : - 1,
    ctr = center ? [- (m - 1) / 2, - (n - 1) / 2, 0]: [0, 0, 0],
    points = [// original data points
        for (i = [0:n - 1])for (j = [0:m - 1]) [j, i, M[i][j]] + ctr,
                [0, 0, minz] + ctr,
                [m - 1, 0, minz] + ctr,
                [m - 1, n - 1, minz] + ctr,
                [0, n - 1, minz] + ctr,
        // additional interpolated points at the center of the quads
        // the points bellow with `med` set to 0 are not used by faces
        for (i = [0:n - 1])for (j = [0:m - 1])
        let(med = i == n - 1 || j == m - 1 ? 0:
                    (M[i][j] + M[i + 1][j] + M[i + 1][j + 1] + M[i][j + 1]) / 4)
                [j + 0.5, i + 0.5, med] + ctr
        ],
    faces = [// faces connecting data points to interpolated ones
        for (i = [0:n - 2])
        for (j = [i * m:i * m + m - 2])
            each [[j + 1, j, j + n * m + 4],
                [j, j + m, j + n * m + 4],
                [j + m, j + m + 1, j + n * m + 4],
                [j + m + 1, j + 1, j + n * m + 4]],
        // lateral and bottom faces
            [for (i = [0:m - 1])           i, n * m + 1, n * m],
            [for (i = [m - 1:- 1:0]) - m + i + n * m, n * m + 3, n * m + 2],
            [for (i = [n - 1:- 1:0])      i * m, n * m, n * m + 3],
            [for (i = [0:n - 1])     i * m + m - 1, n * m + 2, n * m + 1],
            [n * m, n * m + 1, n * m + 2, n * m + 3]
        ]
) [points, faces];

module surfaceData(M, center = false, convexity = 10) {
    a = surfaceDataf(M, center);
    polyhedron(a[0], a[1]);
}
