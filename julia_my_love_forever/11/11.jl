function summa_peregorodok!(r)
    side = Ost
    count = 0
    count_check = 0
    count_summa = 0
    while !isborder(r, side)
        move!(r, side)
        if isborder(r, Nord)
            count += 1
            count_check += 1
        else
            if count == 0 || count_check == 0
                count_summa += 0
            else
                count_summa += 1
                count = 0
                count_check = 0
            end
        end
        if isborder(r, side) && !isborder(r, Nord)
            move!(r, Nord)
            side = inverse(side)
            count = 0
            count_check = 0
        end
    end
    return count_summa
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
