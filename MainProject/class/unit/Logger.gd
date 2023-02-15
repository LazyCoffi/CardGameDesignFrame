extends Node

var log_handle
var time

func _init():
	__initLogHandle()

func assert(flag, msg):
	if flag == true:
		return
	var text = "Error: Assert fail. " + str(msg)
	push_error(text)
	print_debug("Stack trace")
	__write(text, get_stack())

func warning(msg):
	var text = "Warning: " + str(msg)
	push_warning(text)
	print_debug("Stack trace")
	__write(text, null)

func error(msg):
	var text = "Error: " + str(msg)
	push_error(text)
	print_debug("Stack trace")
	__write(text, get_stack())

func log(msg):
	var text = "Log: " + str(msg)
	print(text)
	__write(text, null)

func debug(msg):
	var text = "Debug: " + str(msg)
	print_debug(text)
	var stack_array = get_stack()
	__write(text, stack_array)

func __write(text, stack_array):
	var time_str = __getTimeStr()
	var textline = time_str + " " + str(text) 
	log_handle.store_line(textline)

	if stack_array != null:
		log_handle.store_line("Exception Stack:")	
		for line_dict in stack_array:
			var line = ""
			line += "At: "
			line += "File: "
			line += line_dict["source"] + " "
			line += "Function: "
			line += line_dict["function"] + " "
			line += "Line: "
			line += str(line_dict["line"]) + " "
			log_handle.store_line(line)

	log_handle.flush()

func __getTimeStr():
	return Time.get_datetime_string_from_system()

func __initLogHandle():
	log_handle = File.new()
	log_handle.open("res://log/" + __getTimeStr() + "-log", File.WRITE)
