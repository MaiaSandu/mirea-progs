mutable struct Coordinates
    x::Int64
    y::Int64
end

struct CoordRobot
    robot::Robot
    cords::Coordinates
end

function move_cords!(cords::Coordinates, side)
    if side == Ost
        cords.x += 1
    elseif side == West
        cords.x -= 1
    elseif side == Nord
        cords.y += 1
    elseif side == Sud
        cords.y -= 1
    end
    return cords
end

function try_move_putmarker!(robot::CoordRobot, side, check_x, check_y)
    
    move!(robot.robot, side)
    move_cords!(robot.cords, side)
    x, y = robot.robot.situation.robot_position
    if x == check_x || y == check_y
        putmarker!(robot.robot)
    end
end


function get_cords(cords::Coordinates)
    return cords
end

function solve!(previous_arr::Array, current_arr::Array, robot::CoordRobot, startingPoint_x, startingPoint_y)
    previous_arr[robot.cords.x, robot.cords.y] = true
    for i in 0:3
        side = HorizonSide(i)
        if isborder(robot.robot, side)
            current_arr[robot.cords.x, robot.cords.y] = true
        elseif !previous_arr[robot.cords.x + move_cords!(Coordinates(0, 0), side).x, robot.cords.y + move_cords!(Coordinates(0, 0), side).y]
            try_move_putmarker!(robot, side, startingPoint_x, startingPoint_y)
            solve!(previous_arr, current_arr, robot, startingPoint_x, startingPoint_y)
            try_move_putmarker!(robot, inverse(side), startingPoint_x, startingPoint_y)
        end
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)