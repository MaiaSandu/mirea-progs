include("30.jl")

const x_frame = 15
const y_frame = 15

previous_arr = zeros(Bool, x_frame, y_frame)
current_arr = zeros(Bool, x_frame, y_frame)

r = Robot("untitled.sit", animate = true)
startingPoint_x, startingPoint_y = r.situation.robot_position
println(startingPoint_x, startingPoint_y)
cords_robot = CoordRobot(r, Coordinates(7, 7))
solve!(previous_arr, current_arr, cords_robot, startingPoint_x, startingPoint_y)