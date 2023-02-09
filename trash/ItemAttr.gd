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

func loadPack(data_pack):
	assert(data_pack is Dictionary)

	price = int(data_pack["price"])
	weight = int(data_pack["weight"])
	volume = int(data_pack["volume"])
	skills = data_pack["skills"]
