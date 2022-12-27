using HorizonSideRobots

function mark_square!(r::Robot, n::Int)
    
    counter1 = 1
    counter2 = 1

    while counter1 <= n && !isborder(r, Ost)

        while counter2 < n && !isborder(r, Nord)
            putmarker!(r)
            move!(r, Nord)
            counter2 += 1
        end

        putmarker!(r)
        moves!(r, Sud, counter2 - 1)
        counter2 = 1

        move!(r, Ost)
        counter1 += 1
    end

    if isborder(r, Ost) && counter1 <= n
        while counter2 < n && !isborder(r, Nord)
            putmarker!(r)
            move!(r, Nord)
            counter2 += 1
        end

        putmarker!(r)
        moves!(r, Sud, counter2 - 1)
    end

    moves!(r, West, counter1 - 1)
end

function moves_if_possible_numeric!(r::Robot, side::HorizonSide, n_steps::Int)::Int
    
    while n_steps > 0 && move_if_possible!(r, side)
        n_steps -= 1
    end

    return n_steps
end


function mark_chess!(r::Robot, n::Int)
    
    steps = get_left_down_angle!(r)
    side = Nord
    to_mark = true

    steps_to_ost_border = move_until_border!(r, Ost)
    move_until_border!(r, West)
    last_side = steps_to_ost_border % 2 == 1 ? Sud : Nord
    last_n_steps = 0

    while !isborder(r, Ost)
        while !isborder(r, side)
            if to_mark
                mark_square!(r, n)
            end

            last_n_steps = moves_if_possible_numeric!(r, side, n)
            if last_n_steps == 0 && !isborder(r, side)
                to_mark = !to_mark
            end
        end

        if to_mark
            mark_square!(r, n)
        end

        to_mark = !to_mark

        moves_if_possible!(r, Ost, n)
        moves!(r,inverse_side(side), n - last_n_steps)
        side = inverse_side(side)
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

function move_until_border!(r::Robot, side::HorizonSide)::Int
    n_steps = 0
    while !isborder(r, side)
        n_steps += 1
        move!(r, side)
    end
    return n_steps
end

function moves_if_possible!(r::Robot, side::HorizonSide, n_steps::Int)::Bool
    
    while n_steps > 0 && move_if_possible!(r, side)
        n_steps -= 1
    end

    if n_steps == 0
        return true
    end

    return false
end

function move_if_possible!(r::Robot, side::HorizonSide)::Bool
    if !isborder(r, side)
        move!(r, side)
        return true
    end
    return false
end

function get_left_down_angle!(r::Robot)::NTuple{2, Int}
    steps_to_left_border = move_until_border!(r, West)
    steps_to_down_border = move_until_border!(r, Sud)
    return (steps_to_down_border, steps_to_left_border)
end