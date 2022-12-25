using HorizonSideRobots
include("21.jl")
robot = Robot("untitled.sit", animate = true)
side = readline()
side = parse(Int64, side)
double_dist!(robot, HorizonSide(side), 1)