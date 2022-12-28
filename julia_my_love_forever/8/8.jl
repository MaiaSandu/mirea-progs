function find_the_marker!(r)
    num_steps = 1
    side = Sud
    while !ismarker(r)
        for _i  in 1:2
            move!(r, side)
            side = next(side)
        end
        num_steps += 1
    end
end

next(side::HorizonSide) = HorizonSide((Int(side) +1)% 4)
