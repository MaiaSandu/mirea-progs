function double_dist!(robot, side, n)
    if !isborder(robot, side)
        move!(robot, side)
        double_dist!(robot, side, n+1)
        if !isborder(robot, inverse(side))
            n -= 1
            if n >= 0
                move!(robot, inverse(side))
                if isborder(robot, inverse(side))
                    return false
                end
                move!(robot, inverse(side))
            end
            if isborder(robot, inverse(side))
                if n - 1 < 0
                    return false
                else
                    return true
                end
            else
                return true
            end
        end
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)