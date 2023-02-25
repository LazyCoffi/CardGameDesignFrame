extends Node

func getTimeStamp():
	return Time.get_unix_time_from_system()

func getDateTimeStr():
	return Time.get_datetime_string_from_system()

func getTimeStr():
	return Time.get_time_string_from_system()

func getYearStr():
	var time_dict = Time.get_date_dict_from_system()
	return str(time_dict["year"])

func getMonthStr():
	var time_dict = Time.get_date_dict_from_system()
	return str(time_dict["month"])

func getDayStr():
	var time_dict = Time.get_date_dict_from_system()
	return str(time_dict["day"])

func getWeekdayStr():
	var time_dict = Time.get_date_dict_from_system()
	return str(time_dict["weekday"])

func getHourStr():
	var time_dict = Time.get_time_dict_from_system()
	return str(time_dict["hour"])

func getMinuteStr():
	var time_dict = Time.get_time_dict_from_system()
	return str(time_dict["minute"])

func getSecondStr():
	var time_dict = Time.get_time_dict_from_system()
	return str(time_dict["second"])

func getDateTimeStrFrom(time_stamp):
	return Time.get_datetime_string_from_unix_time(time_stamp)

func getYearStrFrom(time_stamp):
	var time_dict = Time.get_date_dict_from_unix_time(time_stamp)
	return str(time_dict["year"])

func getMonthStrFrom(time_stamp):
	var time_dict = Time.get_date_dict_from_unix_time(time_stamp)
	return str(time_dict["month"])

func getDayStrFrom(time_stamp):
	var time_dict = Time.get_date_dict_from_unix_time(time_stamp)
	return str(time_dict["day"])

func getWeekdayStrFrom(time_stamp):
	var time_dict = Time.get_date_dict_from_unix_time(time_stamp)
	return str(time_dict["weekday"])

func getHourStrFrom(time_stamp):
	var time_dict = Time.get_time_dict_from_unix_time(time_stamp)
	return str(time_dict["hour"])

func getMinuteStrFrom(time_stamp):
	var time_dict = Time.get_time_dict_from_unix_time(time_stamp)
	return str(time_dict["minute"])

func getSecondStrFrom(time_stamp):
	var time_dict = Time.get_time_dict_from_unix_time(time_stamp)
	return str(time_dict["second"])
