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
	var x1
	var y1
	var x2
	var y2
	var x3
	var y3
	var x4
	var y4

	if first[0] == second[0]:
		x1 = first[0] - line_width
		x2 = first[0] + line_width
		y1 = first[1]
		y2 = first[1]
		x3 = second[0] - line_width
		x4 = second[0] + line_width
		y3 = second[1]
		y4 = second[1]
	elif first[1] == second[1]:
		x1 = first[0]
		x2 = first[0]
		y1 = first[1] - line_width
		y2 = first[1] + line_width
		x3 = second[0]
		x4 = second[0]
		y3 = second[1] - line_width
		y4 = second[1] + line_width
	else:
		var k = float(first[1] - second[1]) / float(first[0] - second[0])
		var k_ = -(1 / k)

		x1 = int(float(first[0]) - sqrt(line_width * line_width / (1 + k_ * k_)))
		x2 = int(float(first[0]) + sqrt(line_width * line_width / (1 + k_ * k_)))
		y1 = int(float(first[1]) + k_ * (float(x1 - first[0])))
		y2 = int(float(first[1]) + k_ * (float(x2 - first[0])))
		x3 = int(float(second[0]) - sqrt(line_width * line_width / (1 + k_ * k_)))
		x4 = int(float(second[0]) + sqrt(line_width * line_width / (1 + k_ * k_)))
		y3 = int(float(second[1]) + k_ * (float(x3 - second[0])))
		y4 = int(float(second[1]) + k_ * (float(x4 - second[0])))

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
