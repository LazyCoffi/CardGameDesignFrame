extends Node

func assert(flag, msg := ""):
	if flag == true:
		return
	print_debug("Runtime error! " + msg)
	get_tree().free()
