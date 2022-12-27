function get_on_through_rec!(r::Robot, side::HorizonSide, n_steps::Int = 0)
    if isborder(r, side)
        move!(r, next_side(side))
        n_steps += 1
        get_on_through_rec!(r, side, n_steps)
    else
        move!(r, side)
        along!(r, inverse_side(next_side(side)), n_steps)
    end
end

function next_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 1) % 4)
end

function along!(robot, side, num_steps)
    n_steps = 0
    while !isborder(robot, side) && n_steps < num_steps
        move!(robot, side)
        n_steps += 1
    end
end

function inverse_side(side::HorizonSide)::HorizonSide
    inv_side = HorizonSide((Int(side) + 2) % 4)
    return inv_side
end
