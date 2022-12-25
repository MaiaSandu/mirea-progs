using HorizonSideRobots
include("37.jl")
r = Robot("untitled.sit", animate = true)
x, y = r.situation.robot_position
println(x, y)
mark_perimeter(r, x, y)