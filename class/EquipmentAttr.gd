extends Node
class_name EquipmentAttr

enum EquipmentType {
	WEAPON,
	ARMOR,
	ORNAMENT
}

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

var extra_attr = {} setget setExtraAttr \
						 ,getExtraAttr		# 额外属性
var skill_cards = {} setget setSkill \
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
	assert(attr is EquipmentExtraAttr)
	extra_attr[attr.extra_attr_name] = attr

func delAttr(attr):
	assert(attr is EquipmentExtraAttr)
	extra_attr.erase(attr.extra_attr_name)

func getExtraAttrs():
	return extra_attr.values()

func getExtraAttrNames():
	return extra_attr.keys()

func addSkill(skill):
	assert(skill is SkillCard)
	skill_cards[skill.s_name] = skill

func delSkill(skill):
	assert(skill is SkillCard)
	skill_cards.erase(skill.s_name)

func getSkillCards():
	return skill_cards.values()

func getSkillCardNames():
	return skill_cards.keys()

func load_pack(data_pack):
	#TODO
	pass

func pack():
	#TODO
	pass
