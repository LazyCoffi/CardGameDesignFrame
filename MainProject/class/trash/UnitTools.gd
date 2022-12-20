extends Node

func toolInit():
	randomize()

func randn(l, r):
	assert(l is int)
	assert(r is int)
	return l + randi() % (r - l + 1)

func rrange(r):
	return randi() % r
 
