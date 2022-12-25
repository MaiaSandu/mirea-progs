function try_move!(robot, side)
    if isborder(robot, side)
        return false
    else 
        move!(robot, side)
        return true
    end
end


function along!(robot, side)
    while try_move!(robot, side) # - в этом логическом выражении порядок аргументов важен!
    end
end

function snake!( robot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost)) # - это обобщенная функция
    # Робот - в (inverse(next_row_side), inverse(move_side))-углу поля
    along!(robot, move_side)
    while try_move!(robot, next_row_side)
        move_side = inverse(move_side)
        along!(robot, move_side)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)