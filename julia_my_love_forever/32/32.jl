using HorizonSideRobots
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

function try_move_putmarker!(robot::CoordRobot, side, startingPoint_x, startingPoint_y)
    move_cords!(robot.cords, side)
    move!(robot.robot, side)
    if intial_temperature < temperature(robot.robot)
        global intial_temperature = temperature(robot.robot)
        global x, y = robot.robot.situation.robot_position
    end
    
     if !ismarker(robot.robot)
         putmarker!(robot.robot)
     end
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

global x = 12 - x

global path_robot =  Array{String}(undef, 16, 16)

list_column = 1:16
list_row = 1:16
for i in list_column
    for j in list_row
        path_robot[i, j] = "free"
    end
end

startingPoint = Coordinates(7, 7)
previousPoint = Coordinates(2, 1)
endingPoint = Coordinates(y, x)



 function HorizonSideRobots.move!(robot::CoordRobot, side)
     move!(robot.robot, side)
     move!(robot.cords, side)
 end

function get_robot(robot::Robot, side)
    move!(robot, side)
    return robot
end

function get_cords(cords::Coordinates, side)
    move_cords!(cords, side)
    return cords
end

function set_path(cords::Coordinates, situation::String)
    global path_robot[cords.x, cords.y] = situation
    return path_robot[cords.x, cords.y-1]
end


function solve!(robot::Robot, cords::Coordinates)
    a = set_path(cords, "occupied")
    x_diff = cords.x - previousPoint.x
    y_diff = cords.y - previousPoint.y
    println(cords.x,  " " , cords.y, " ", previousPoint.x, " ", previousPoint.y, " ", x_diff, " ", y_diff, " ", a)
    previousPoint.x = cords.x
    previousPoint.y = cords.y
    
    if cords.x == endingPoint.x + 2 && cords.y == endingPoint.y + 2 
        return true
    end

    if !isborder(robot, Nord) 
        if path_robot[cords.x, cords.y + 1] == "free" 
            if solve!(get_robot(robot, Nord), get_cords(cords, Nord)) 
                return true
            end
        end
    end

    if !isborder(robot, Sud) 
        if path_robot[cords.x, cords.y - 1] == "free" 
            if solve!(get_robot(robot, Sud), get_cords(cords, Sud))
                return true
            end
        end
    end

    if !isborder(robot, Ost) 
        if path_robot[cords.x + 1 , cords.y] == "free" 
            if solve!(get_robot(robot,Ost), get_cords(cords, Ost))
                return true
            end
        end
    end

    if !isborder(robot, West) 
        if path_robot[cords.x - 1, cords.y] == "free" 
            if solve!(get_robot(robot, West), get_cords(cords, West))
                return true
            end
        end
    end
    if (y_diff == 1) 
         set_path(cords, "free")
        move!(robot, Sud)
        get_cords(cords, Sud)
         
    elseif (y_diff == -1)
         set_path(cords, "free")
        move!(robot, Nord)
        get_cords(cords, Nord)
        
     elseif (x_diff == 1) 
        set_path(cords, "free")
        move!(robot, West)
        get_cords(cords, West)
        
    elseif (x_diff == -1)
        set_path(cords, "free")
        move!(robot, Ost)
        get_cords(cords, Ost)
        
    end
    x_diff = cords.x - previousPoint.x
    y_diff = cords.y - previousPoint.y
    println(cords.x,  " " , cords.y, " ", previousPoint.x, " ", previousPoint.y, " ", x_diff, " ", y_diff, " ", a)
    previousPoint.x = cords.x
    previousPoint.y = cords.y
    return false
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)