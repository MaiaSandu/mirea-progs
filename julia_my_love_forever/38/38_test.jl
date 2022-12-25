using HorizonSideRobots
include("38.jl")
r = Robot("untitled.sit", animate = true)
x, y = r.situation.robot_position
mark_perimeter(r, x, y)