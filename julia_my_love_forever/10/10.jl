using HorizonSideRobots
n = readline()
n = parse(Int64, n)
include("10.jl")
r = Robot("untitled.sit", animate = true)
draw_chess_square!(r, n)