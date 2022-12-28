using HorizonSideRobots

function find_space2!(r)
    tmp = (side::HorizonSide) -> isborder(r, Nord)
    shatl!(tmp, r)
end

function shatl!(stop_condition::Function, robot)
    side = Nord
    num_steps = 1
    next_side = next(side)
    while stop_condition(side)
        moves!(r, next_side, num_steps)
        num_steps += 1
        next_side = inverse(next_side)
    end
end

function moves!(r, side, num_steps)
    for _i in 1:num_steps
        move!(r, side)
    end
end

inverse(next_side::HorizonSide) = HorizonSide((Int(next_side)+2)%4)
next(side::HorizonSide) = HorizonSide((Int(side)+1)%4)

r = Robot("untitled.sit", animate = true)
find_space2!(r)
