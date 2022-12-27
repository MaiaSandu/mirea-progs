using HorizonSideRobots

function find_marker!(r::Robot)
    tmp = (side::HorizonSide) -> ismarker(r)
    spiral!( tmp, r)
end

function spiral!(stop_condition::Function, robot)
    n_steps = 1
    side = Ost
    while !stop_condition(side)
        along!(stop_condition, robot, side, n_steps)
        side = next_side(side)
        along!(stop_condition, robot, side, n_steps)
        side = next_side(side)
        n_steps +=1
    end
end

function along!(stop_condition, robot, side, max_num)
    n_steps = 0
    while !stop_condition(side) && n_steps < max_num
        move!(robot, side)
        n_steps += 1
    end
    return n_steps
end

function next_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 1) % 4)
end
