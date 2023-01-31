extends Node

func randInt(l, r):
	randomize()
	return l + randi() % (r - l + 1)

func randFloat(l, r):
	randomize()
	return l + randf() * (r - l)

func toInt(val):
	return int(val)

func toFloat(val):
	return float(val)
