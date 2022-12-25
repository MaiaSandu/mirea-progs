using HorizonSideRobots
mutable struct Coordinates
    x::Int64
    y::Int64
end

struct CoordRobot
    robot::Robot
    cords::Coordinates
end

global area = 0

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

function try_move_putmarker!(robot::CoordRobot, side)
    move!(robot.robot, side)
    if !ismarker(robot.robot)
        global area += 1
        putmarker!(robot.robot)
    end

    move_cords!(robot.cords, side)
end


function get_cords(cords::Coordinates)
    return cords
end

function solve!(previous_arr::Array, current_arr::Array, robot::CoordRobot)
    previous_arr[robot.cords.x, robot.cords.y] = true
    for i in 0:3
        side = HorizonSide(i)
        if isborder(robot.robot, side)
            current_arr[robot.cords.x, robot.cords.y] = true
        elseif !previous_arr[robot.cords.x + move_cords!(Coordinates(0, 0), side).x, robot.cords.y + move_cords!(Coordinates(0, 0), side).y]
            try_move_putmarker!(robot, side)
            solve!(previous_arr, current_arr, robot)
            try_move_putmarker!(robot, inverse(side))
        end
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)