using HorizonSideRobots

function double_perimetr!(r)
    putmarker!(r)
    side = Ost
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
        if isborder(r, side) && !isborder(r, Nord)
            move!(r, Nord)
            putmarker!(r)
            side = inverse(side)
        end
    end
    along!(r, Sud)
    side = West
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
        if isborder(r, side) && !isborder(r, Nord)
            move!(r, Nord)
            putmarker!(r)
            side = inverse(side)
        end
    end
end

function along!(r, side)
    while !isborder(r, side)
        move!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
