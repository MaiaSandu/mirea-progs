function find_the_marker!(r)
    num_steps = 1
    side = Sud
    while !ismarker(r)
        for _i  in 1:2
            the_marker_is_found!(r, side, num_steps)
            side = next(side)
        end
        num_steps += 1
    end
end

function the_marker_is_found!(r, side, num_steps)
    for _i in 1:num_steps
        if !ismarker(r)
            move!(r, side)
        else
            break
        end
    end
end

next(side::HorizonSide) = HorizonSide((Int(side) +1)% 4)
