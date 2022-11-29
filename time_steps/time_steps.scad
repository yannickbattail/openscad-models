
function t_steps(t, nb_step) = [
    for (step = [0:nb_step-1])
        (t <= step / nb_step)
        ? 0
        : ((t >= (step+1) / nb_step)
            ? 1
            : (t - (step / nb_step)) * nb_step)
    ];

function time_steps(nb_step) =  t_steps($t, nb_step);
