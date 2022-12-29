extends Node

func randInt(l, r):
	return l + randi() % (r - l + 1)

func randFloat(l, r):
	return l + randf() * (r - l)
