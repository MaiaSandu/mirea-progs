function isborder_in(robot, side)
    x, y = robot.situation.robot_position
    if isborder(robot, side) && (x != 1 && y != 1 && x != 11 && y != 12)
        return true
    else
        return false
    end
    
end

function mark_perimeter(robot, s_x, s_y)
    putmarker!(robot)
    side = Ost
    diff_x, diff_y = 0, 0
    result_x, result_y = s_x, s_y   
    max_diff = 0 
    while true
        
        if isborder_in(robot, Ost) && !isborder_in(robot, inverse(Ost))
            side = Sud
        elseif isborder_in(robot, Sud) && !isborder_in(robot, inverse(Sud))
            side = West
        elseif isborder_in(robot, West) && !isborder_in(robot, inverse(West))
            side = Nord
        elseif isborder_in(robot, Nord) && !isborder_in(robot, inverse(Nord))
            side = Ost
        end

        if isborder_in(robot, Ost) && isborder_in(robot, Sud) 
            side = West
        elseif isborder_in(robot, West) && isborder_in(robot, Nord)
            side = Ost
        elseif isborder_in(robot, Sud) && isborder_in(robot, West)
            side = Nord
        elseif isborder_in(robot, Nord) && isborder_in(robot, Ost)
            side = Sud
        end

        if isborder(robot, Ost) && isborder(robot, Sud) && isborder(robot, Nord)
            side = West
        elseif isborder(robot, West) && isborder(robot, Sud) && isborder(robot, Nord)
            side = Ost
        elseif isborder(robot, Ost) && isborder(robot, Sud) && isborder(robot, West)
            side = Nord
        elseif isborder(robot, Ost) && isborder(robot, West) && isborder(robot, Nord)
            side = Sud
        end

        if !isborder_in(robot, side) && !isborder_in(robot, next(side))
            side = next(side)
        end
        x, y = robot.situation.robot_position
        if isborder(robot, side) && isborder(robot, inverse(side)) && (x == 1 || y == 1 || x == 11 || y == 12)
            side = left(side)
        end

        move!(robot, side)
        x, y = robot.situation.robot_position
        max_diff = max(diff_x, diff_y) 
        if (abs(x - s_x) > diff_x)
            diff_x = abs(x - s_x)
        end
        if (abs(y - s_y) > diff_y)
            diff_y = abs(y - s_y)
        end
        println(diff_x, " ", diff_y)
        if (max(diff_x, diff_y) > max_diff)
            result_x = x
            result_y = y
        end

        if (x == s_x && y == s_y)
            break
        end
        if isborder(robot, side) || isborder(robot, next(side))
            putmarker!(robot)
        end

        
    end
    while true
        
        if isborder_in(robot, Ost) && !isborder_in(robot, inverse(Ost))
            side = Sud
        elseif isborder_in(robot, Sud) && !isborder_in(robot, inverse(Sud))
            side = West
        elseif isborder_in(robot, West) && !isborder_in(robot, inverse(West))
            side = Nord
        elseif isborder_in(robot, Nord) && !isborder_in(robot, inverse(Nord))
            side = Ost
        end

        if isborder_in(robot, Ost) && isborder_in(robot, Sud) 
            side = West
        elseif isborder_in(robot, West) && isborder_in(robot, Nord)
            side = Ost
        elseif isborder_in(robot, Sud) && isborder_in(robot, West)
            side = Nord
        elseif isborder_in(robot, Nord) && isborder_in(robot, Ost)
            side = Sud
        end

        if isborder(robot, Ost) && isborder(robot, Sud) && isborder(robot, Nord)
            side = West
        elseif isborder(robot, West) && isborder(robot, Sud) && isborder(robot, Nord)
            side = Ost
        elseif isborder(robot, Ost) && isborder(robot, Sud) && isborder(robot, West)
            side = Nord
        elseif isborder(robot, Ost) && isborder(robot, West) && isborder(robot, Nord)
            side = Sud
        end

        if !isborder_in(robot, side) && !isborder_in(robot, next(side))
            side = next(side)
        end
        x, y = robot.situation.robot_position
        if isborder(robot, side) && isborder(robot, inverse(side)) && (x == 1 || y == 1 || x == 11 || y == 12)
            side = left(side)
        end

        move!(robot, side)
        if (x == result_x && y == result_y)
            break
        end
    end
    
end

next(side::HorizonSide) = HorizonSide((Int(side) +1)% 4)
inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)
left(side::HorizonSide) = HorizonSide((Int(side) +3)% 4)