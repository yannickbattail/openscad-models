
/**
 * Function that return an array of steps to be use in animations the same way we use $t
 * example for t=time_steps(4)
 * when $t grows from 0    to 0.25 , t[0] grows from 0 ot 1
 * when $t grows from 0.25 to 0.5  , t[1] grows from 0 ot 1
 * when $t grows from 0.5  to 0.75 , t[2] grows from 0 ot 1
 * when $t grows from 0.75 to 1    , t[3] grows from 0 ot 1
 *
 * @param nb_step integer number: number of steps. It must be > 0
 * @return array of float number: it has a length of nb_step and contain a number between 0 and 1
 */
function time_steps(nb_step) =  t_steps($t, nb_step);

/**
 * @param t float number: the time
 * @param nb_step integer number: number of steps. It must be > 0
 * @return array of float number: it has a length of nb_step and contain a number between 0 and 1
 */
function t_steps(t, nb_step) = [
    for (step = [0:nb_step-1])
        (t <= step / nb_step)
        ? 0
        : ((t >= (step+1) / nb_step)
        ? 1
        : (t - (step / nb_step)) * nb_step)
    ];
