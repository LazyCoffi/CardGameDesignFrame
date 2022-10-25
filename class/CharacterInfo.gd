extends Node
class_name CharacterInfo

enum Race {
	HUMAN,
	ELF,
	ORC,
	DWARF
}

enum Gender {
	MALE,
	FEMALE
}

var c_name setget setName
var race setget setRace
var gender setget setGender
var age setget setAge
var height setget setHeight
var weight setget setWeight
var introduction setget setIntroduction
var avator setget setAvator

func setName(c_name_):
	if c_name != null:
		return
	c_name = c_name_

func setRace(race_):
	assert(Race.has(race_))
	if race != null:
		return
	race = race_

func setGender(gender_):
	assert(Gender.has(gender_))
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

func setAvator(avator_):
	if avator != null:
		return
	avator = avator_

func pack():
	#TODO: 打包为存档文件
	pass

func loadData(data_pack):
	#TODO: 读取存档文件
	pass
