using HorizonSideRobots
include("39.jl")
r = Robot("untitled.sit", animate = true)
const x_frame = 15
const y_frame = 15

previous_arr = zeros(Bool, x_frame, y_frame)
current_arr = zeros(Bool, x_frame, y_frame)

cords_robot = CoordRobot(r, Coordinates(5, 9))
global x, y = r.situation.robot_position
solve!(previous_arr, current_arr, cords_robot)
println(area)