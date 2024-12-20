function hsv(h, s = 1, v = 1, a = 1, p, q, t) = (p == undef || q == undef || t == undef)
    ? hsv(
        (h % 1) * 6,
        s < 0?0:s > 1?1:s,
        v < 0?0:v > 1?1:v,
    a,
        (v < 0?0:v > 1?1:v) * (1 - (s < 0?0:s > 1?1:s)),
        (v < 0?0:v > 1?1:v) * (1 - (s < 0?0:s > 1?1:s) * ((h % 1) * 6 - floor((h % 1) * 6))),
        (v < 0?0:v > 1?1:v) * (1 - (s < 0?0:s > 1?1:s) * (1 - ((h % 1) * 6 - floor((h % 1) * 6))))
    )
    :
            h < 1 ? [v, t, p, a] :
                    h < 2 ? [q, v, p, a] :
                            h < 3 ? [p, v, t, a] :
                                    h < 4 ? [p, q, v, a] :
                                            h < 5 ? [t, p, v, a] :
                                                    [v, p, q, a];
