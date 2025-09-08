# pipe library

## pipe1

```openscad
//   outer_radius, inner_radius, list of segments
pipe(10          , 7           , [
        //length,rotation,angle,radius_of_curvature 
        [200    , 0      , 90  , 10],
        [120    , 90     , 120 , 20],
        [100    , 0      , 120 , 20],
        [60     , 0      , 0   , 20]
    ]);
```

## pipe2

```openscad
pipe([
        //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
        [200    , 50               , 47                , 20             , 17              , 0      , 90  , 20                , "green"           , "red"],
        [200    , 20               , 17                , 10             , 7                , 90    , 120 , 20                , "blue"            , "orange"],
    ]);
```
