using HorizonSideRobots

function get_left_down_angle_modified!(r::Robot)::Vector{Tuple{HorizonSide, Int}}
    steps = []
    while !(isborder(r, West) && isborder(r, Sud))
        steps_to_West = move_until_border!(r, West)
        steps_to_Sud = move_until_border!(r, Sud)
        push!(steps, (West, steps_to_West))
        push!(steps, (Sud, steps_to_Sud))
    end
    return steps
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

function way_back!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    inv_path = inversed_path(path)
    way!(r, inv_path)
end

function way!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    for step in path
        moves!(r, step[1], step[2])
    end
end



function move_until_border!(r::Robot, side::HorizonSide)::Int
    n_steps = 0
    while !isborder(r, side)
        n_steps += 1
        move!(r, side)
    end
    return n_steps
end

function move_if_possible!(r::Robot, side::HorizonSide)::Bool
    if !isborder(r, side)
        move!(r, side)
        return true
    end
    return false
end

function inversed_path(path::Vector{Tuple{HorizonSide, Int}})::Vector{Tuple{HorizonSide, Int}}
    inv_path = []
    for step in path
        inv_step = (inverse_side(step[1]), step[2])
        push!(inv_path, inv_step)
    end
    reverse!(inv_path)
    return inv_path
end

function make_way!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    for step in path
        moves!(r, step[1], step[2])
    end
end

function make_way_back!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    inv_path = inversed_path(path)
    make_way!(r, inv_path)
end

function squer!(robot)
    for side in (Nord, Ost, Sud, West)
        while ! isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        end
    end
end

function task!(r::Robot)
    steps = get_left_down_angle_modified!(r)
    squer!(r)

    while isborder(r, Sud) && !isborder(r, Ost)
        while !isborder(r, Ost) && move_if_possible!(r, Nord) end
        if !isborder(r, Ost)
            move!(r, Ost)
        end
        while !isborder(r, Ost) && move_if_possible!(r, Sud) end
        if !isborder(r, Ost)
            move!(r, Ost)
        end
    end

    for sides in [(Sud, Ost), (Ost, Nord), (Nord, West), (West, Sud), (Sud, Ost)]
        side_to_move, side_to_border = sides
        while isborder(r, side_to_border) && !ismarker(r)
            putmarker!(r)
            move!(r, side_to_move)
        end
        if ismarker(r)
            break
        end
        putmarker!(r)
        move!(r, side_to_border)
    end

    get_left_down_angle_modified!(r)
    way_back!(r, steps)
end
#r = Robot("squer_hard.sit", animate=true)
#task!(r)