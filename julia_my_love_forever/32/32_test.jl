using HorizonSideRobots

include("32.jl")

const x_frame = 15
const y_frame = 15

previous_arr = zeros(Bool, x_frame, y_frame)
current_arr = zeros(Bool, x_frame, y_frame)


r = Robot("untitled.sit", animate = true)
intial_temperature = temperature(r)
startingPoint_x, startingPoint_y = r.situation.robot_position
global intial_temperature = temperature(r)
global x, y = r.situation.robot_position
cords_robot = CoordRobot(r, Coordinates(8, 9))
solve!(previous_arr, current_arr, cords_robot, startingPoint_x, startingPoint_y)
println(intial_temperature)
println(x, y)

startingPoint = Coordinates(8, 9)
solve!(r, startingPoint)