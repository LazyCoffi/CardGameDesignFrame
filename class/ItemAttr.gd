extends Node
class_name ItemAttr

var price setget setPrice
var weight setget setWeight
var volume setget setVolume

var skills = {}

func setPrice(price_):
	assert(price_ > 0)
	price = price_

func setWeight(weight_):
	assert(weight_ > 0)
	weight = weight_

func setVolume(volume_):
	assert(volume_ > 0)
	volume = volume_

func addSkill(skill_):
	assert(skill_ is SkillCard)
	skills[skill_.s_name] = skill_

func delSkill(skill_):
	assert(skill_ is SkillCard)
	skills.erase(skill_.s_name)

func getSkills():
	return skills.values()

func getSkillNames():
	return skills.keys()

func pack():
	var data_pack = {}
	data_pack["price"] = price
	data_pack["weight"] = weight
	data_pack["volume"] = volume
	data_pack["skills"] = skills
	
	return data_pack

func loadSkills():
	for key in skills.keys():
		skills[key] = CardTemplate.getCard(key)

static func loadPack(data_pack):
	var attr = load("res://class/ItemAttr.gd").new()
	attr.price = data_pack["price"]
	attr.weight = data_pack["weight"]
	attr.volume = data_pack["volume"]
	attr.skills = data_pack["skills"]
	
	return attr
