extends Node
class_name CharacterAttr

var strength setget setStrength
var agility setget setAgility
var insight setget setInsight
var intelligence setget setIntelligence
var perserverance setget setPerserverance
var mystery setget setMystery
var belief setget setBelief
var physique setget setPhysique
var speed setget setSpeed

var survive setget setSurvive
var social setget setSocial
var dexterity setget setDexterity
var knowledge setget setKnowledge

func setStrength(strength_):
	assert(strength_ > 0)
	strength = strength_

func setAgility(agility_):
	assert(strength > 0)
	agility = agility_

func setInsight(insight_):
	assert(insight_ > 0)
	insight = insight_

func setIntelligence(intelligence_):
	assert(intelligence_ > 0)
	intelligence = intelligence_

func setPerserverance(perserverance_):
	assert(perserverance_ > 0)
	perserverance = perserverance_

func setMystery(mystery_):
	assert(mystery_ > 0)
	mystery = mystery_

func setBelief(belief_):
	assert(belief_ > 0)
	belief = belief_

func setPhysique(physique_):
	assert(physique_ > 0)
	physique = physique_

func setSpeed(speed_):
	assert(speed_ > 0)
	speed = speed_

func setSurvive(survive_):
	assert(survive_ > 0)
	survive = survive_

func setSocial(social_):
	assert(social_ > 0)
	social = social_

func setDexterity(dexterity_):
	assert(dexterity_ > 0)
	dexterity = dexterity_

func setKnowledge(knowledge_):
	assert(knowledge_ > 0)
	knowledge = knowledge_
	
func pack():
	var data_pack = {}
	data_pack["strength"] = strength
	data_pack["agility"] = agility
	data_pack["insight"] = insight
	data_pack["intelligence"] = intelligence
	data_pack["perserverance"] = perserverance
	data_pack["mystery"] = mystery
	data_pack["belief"] = belief
	data_pack["physique"] = physique
	data_pack["speed"] = speed
	data_pack["survive"] = survive
	data_pack["social"] = social
	data_pack["dexterity"] = dexterity
	data_pack["knowledge"] = knowledge
	
	return data_pack

static func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	var attr = load("res://class/CharacterAttr.gd").new()
	attr.strength = int(data_pack["strength"])
	attr.agility = int(data_pack["agility"])
	attr.insight = int(data_pack["insight"])
	attr.intelligence = int(data_pack["intelligence"])
	attr.perserverance = int(data_pack["perserverance"])
	attr.mystery = int(data_pack["mystery"])
	attr.belief = int(data_pack["belief"])
	attr.physique = int(data_pack["physique"])
	attr.speed = int(data_pack["speed"])
	attr.survive = int(data_pack["survive"])
	attr.social = int(data_pack["social"])
	attr.dexterity = int(data_pack["dexterity"])
	attr.knowledge = int(data_pack["knowledge"])
		
	return attr
