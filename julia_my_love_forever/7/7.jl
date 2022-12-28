using HorizonSideRobots

function prohod!(r, side)
    num_steps = 1
    next_side = next(side)
    while isborder(r, side)
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
