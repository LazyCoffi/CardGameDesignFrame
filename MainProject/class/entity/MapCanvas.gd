extends Node2D
class_name MapCanvas

var lines
var line_width

func setLines(lines_):
	lines = lines_	

func setLineWidth(line_width_):
	line_width = line_width_

func setPosition(position_):
	position = position_

func drawMapLine(first, second):
	var k = float(first[1] - second[1]) / float(first[0] - second[0])
	var k_ = -(1 / k)

	var x1 = int(float(first[0]) - sqrt(line_width * line_width / (1 + k_ * k_)))
	var x2 = int(float(first[0]) + sqrt(line_width * line_width / (1 + k_ * k_)))
	var y1 = int(float(first[1]) + k_ * (float(x1 - first[0])))
	var y2 = int(float(first[1]) + k_ * (float(x2 - first[0])))
	var x3 = int(float(second[0]) - sqrt(line_width * line_width / (1 + k_ * k_)))
	var x4 = int(float(second[0]) + sqrt(line_width * line_width / (1 + k_ * k_)))
	var y3 = int(float(second[1]) + k_ * (float(x3 - second[0])))
	var y4 = int(float(second[1]) + k_ * (float(x4 - second[0])))

	var points = PoolVector2Array()
	points.append(Vector2(x1, y1))
	points.append(Vector2(x2, y2))
	points.append(Vector2(x4, y4))
	points.append(Vector2(x3, y3))

	var color = ResourceUnit.loadRes("MapCanvas", "MapCanvas", "map_line_color")
	
	draw_colored_polygon(points, color)

func drawLines():
	for line in lines:
		drawMapLine(line[0], line[1])

func _draw():
	drawLines()
