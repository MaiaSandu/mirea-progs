using HorizonSideRobots

function find_space!(r::Robot, side::HorizonSide)
    n_steps = 1
    ort_side = HorizonSide((Int(side) + 1) % 4)
    while isborder(r, side)
        moves!(r, ort_side, n_steps)
        n_steps += 1
        ort_side = inverse_side(ort_side)
    end
end


function moves!(r::Robot, side::HorizonSide, n_steps::Int)
    for i in 1:n_steps
        move!(r, side)
    end
end

function inverse_side(side::HorizonSide)::HorizonSide
    side = HorizonSide((Int(side) + 2) % 4)
    return side
end
