extends Node
class_name CharacterInfo

var c_name setget setName
var race setget setRace
var gender setget setGender
var age setget setAge
var height setget setHeight
var weight setget setWeight
var introduction setget setIntroduction
var avator_name setget setAvatorName
var avator

func setName(c_name_):
	if c_name != null:
		return
	c_name = c_name_

func setRace(race_):
	if race != null:
		return
	race = race_

func setGender(gender_):
	if gender != null:
		return
	gender = gender_

func setAge(age_):
	assert(age_ > 0)
	if age != null:
		return
	age = age_

func setHeight(height_):
	assert(height_ > 0)
	height = height_

func setWeight(weight_):
	assert(weight_ > 0)
	weight = weight_

func setIntroduction(introduction_):
	if introduction != null:
		return
	introduction = introduction_

func setAvatorName(avator_name_):
	if avator_name != null:
		return
	avator_name = avator_name_

func pack():
	var data_pack = {}
	data_pack["c_name"] = c_name
	data_pack["race"] = race
	data_pack["gender"] = gender
	data_pack["age"] = age
	data_pack["height"] = height
	data_pack["weight"] = weight
	data_pack["introduction"] = introduction
	data_pack["avator_name"] = avator_name

func loadAvator():
	avator = ResourceTool.loadImage(avator_name)

func loadPack(data_pack):
	assert(data_pack is Dictionary)

	c_name = data_pack["c_name"]
	race = data_pack["race"]
	gender = data_pack["gender"]
	age = int(data_pack["age"])
	height = int(data_pack["height"])
	weight = int(data_pack["weight"])
	introduction = data_pack["introduction"]
	avator_name = data_pack["avator_name"]
