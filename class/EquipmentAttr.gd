extends Node
class_name EquipmentAttr

var weight setget setWeight					# 武器重量
var blunt setget setBlunt					# 钝器伤害
var sharp setget setSharp					# 锐器伤害
var agile setget setAgile					# 敏捷性
var flame setget setFlame					# 火属性
var thunder setget setThunder				# 雷属性
var frost setget setFrost					# 霜冻属性
var poison setget setPoison					# 毒属性
var divine setget setDivine					# 神圣属性
var dark setget setDark						# 暗属性
var volume setget setVolume					# 体积
var type setget setType						# 装备大类
var inner_type setget setInnerType			# 装备种类

var extra_attrs = {} setget setExtraAttr \
						 ,getExtraAttr		# 额外属性
var skills = {} setget setSkill \
					 ,getSkill				# 附带技能

func setWeight(weight_):
	assert(weight_ > 0)
	weight = weight_

func setBlunt(blunt_):
	assert(blunt_ > 0)
	blunt = blunt_

func setSharp(sharp_):
	assert(sharp_ > 0)
	sharp = sharp_

func setAgile(agile_):
	assert(agile_ > 0)
	agile = agile

func setFlame(flame_):
	assert(flame_)
	flame = flame_

func setThunder(thunder_):
	assert(thunder_ > 0)
	thunder = thunder_

func setFrost(frost_):
	assert(frost_ > 0)
	frost = frost_

func setPoison(poison_):
	assert(poison_ > 0)
	poison = poison_

func setDivine(divine_):
	assert(divine_ > 0)
	divine = divine_

func setDark(dark_):
	assert(dark_ > 0)
	dark = dark_

func setVolume(volume_):
	assert(volume_ > 0)
	volume = volume_
	
func setType(type_):
	type = type_

func setInnerType(inner_type_):
	assert(inner_type_ is String)
	inner_type = inner_type_
	
func setExtraAttr(extraAttr_):
	return

func setSkill(skill_):
	return

func getExtraAttr():
	return

func getSkill():
	return

func addAttr(attr):
	extra_attrs[attr.attr] = attr

func delAttr(attr):
	extra_attrs.erase(attr.attr)

func getExtraAttrs():
	return extra_attrs.values()

func getExtraAttrNames():
	return extra_attrs.keys()

func addSkill(skill):
	assert(skill is SkillCard)
	skills[skill.s_name] = skill

func delSkill(skill):
	assert(skill is SkillCard)
	skills.erase(skill.s_name)

func getSkillCards():
	return skills.values()

func getSkillCardNames():
	return skills.keys()

func pack():
	var data_pack = {}
	data_pack["weight"] = weight
	data_pack["blunt"] = blunt
	data_pack["sharp"] = sharp
	data_pack["agile"] = agile
	data_pack["flame"] = flame
	data_pack["thunder"] = thunder
	data_pack["frost"] = frost
	data_pack["poison"] = poison
	data_pack["divine"] = divine
	data_pack["dark"] = dark
	data_pack["volume"] = volume
	data_pack["type"] = type
	data_pack["inner_type"] = inner_type
	data_pack["extra_attrs"] = extra_attrs
	data_pack["skills"] = skills
	
	return data_pack

func loadSkills():
	for key in skills.keys():
		skills[key] = CardTemplate.getCard(key)

static func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	var attr = load("res://class/EquipmentAttr.gd").new()
	attr.weight = int(data_pack["weight"])
	attr.blunt = int(data_pack["blunt"])
	attr.sharp = int(data_pack["sharp"])
	attr.agile = int(data_pack["agile"])
	attr.flame = int(data_pack["flame"])
	attr.thunder = int(data_pack["thunder"])
	attr.frost = int(data_pack["frost"])
	attr.poison = int(data_pack["poison"])
	attr.divine = int(data_pack["divine"])
	attr.dark = int(data_pack["dark"])
	attr.volume = int(data_pack["volume"])
	attr.type = data_pack["type"]
	attr.inner_type = data_pack["inner_type"]
	attr.extra_attr = data_pack["extra_attr"]
	attr.skills = data_pack["skills"]
	
	return attr
