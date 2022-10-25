extends Node
class_name CharacterState

var max_head_hp setget setMaxHeadHP
var head_hp setget setHeadHP
var max_chest_hp setget setMaxChestHP
var chest_hp setget setChestHP
var max_left_arm_hp setget setMaxLeftArmHP
var left_arm_hp setget setLeftArmHP
var max_right_arm_hp setget setMaxRightArmHP
var right_arm_hp setget setRightArmHP
var max_left_leg_hp setget setMaxLeftLegHP
var left_leg_hp setget setMaxLeftLegHP
var max_right_leg_hp setget setRightLegHP
var right_leg_hp setget setRightLegHP
var max_stress setget setMaxStress
var stress setget setStress
var max_weight setget setMaxWeight
var weight setget setWeight
var max_power setget setMaxPower
var power setget setPower

var static_buff = []
var continous_buff = []

func setMaxHeadHP(max_head_hp_):
	max_head_hp = max(max_head_hp_, 1)

func setHeadHP(head_hp_):
	assert(max_head_hp != null)
	head_hp = max(0, head_hp_)
	head_hp = min(max_head_hp, head_hp)

func setMaxChestHP(max_chest_hp_):
	max_chest_hp = max(max_chest_hp_, 1)

func setChestHP(chest_hp):
	assert(max_chest_hp != null)
	chest_hp = max(0, head_hp)
	chest_hp = min(max_chest_hp, chest_hp)
	
func setMaxLeftArmHP(max_left_arm_hp_):
	max_left_arm_hp = max(max_left_arm_hp_, 1)

func setLeftArmHP(left_arm_hp_):
	assert(max_left_arm_hp != null)
	left_arm_hp = max(0, left_arm_hp_)
	left_arm_hp = max(max_left_arm_hp, left_arm_hp)

func setMaxRightArmHP(max_right_arm_hp_):
	max_right_arm_hp = max(max_right_arm_hp_, 1)

func setRightArmHP(right_arm_hp_):
	assert(max_right_arm_hp != null)
	right_arm_hp = max(0, right_arm_hp_)
	right_arm_hp = max(max_right_arm_hp, right_arm_hp)
	
func setMaxLeftLegHP(max_left_leg_hp_):
	max_left_leg_hp = max(max_left_leg_hp_, 1)

func setLeftLegHP(left_leg_hp_):
	assert(max_left_leg_hp != null)
	left_leg_hp = max(0, left_leg_hp_)
	left_leg_hp = max(max_left_leg_hp, left_leg_hp)

func setMaxRightLegHP(max_right_leg_hp_):
	max_right_leg_hp = max(max_right_leg_hp_, 1)

func setRightLegHP(right_leg_hp_):
	assert(max_right_leg_hp != null)
	right_leg_hp = max(0, right_leg_hp_)
	right_leg_hp = max(max_right_leg_hp, right_leg_hp)

func setMaxStress(max_stress_):
	max_stress = max(max_stress_, 1)
	
func setStress(stress_):
	assert(max_stress != null)
	stress = max(0, stress_)
	stress = max(max_stress, stress)
	
func setMaxWeight(max_weight_):
	max_weight = max(max_weight_, 1)

func setWeight(weight_):
	assert(max_weight != null)
	weight = max(0, weight_)
	weight = max(max_weight, weight)

func setMaxPower(max_power_):
	max_power = max(max_power_, 1)

func setPower(power_):
	assert(max_power != null)
	power = max(0, power_)
	power = max(max_power, power)
	
func load_pack(data_pack):
	#TODO
	pass

func pack():
	#TODO
	pass
