extends GutTest

const MonsterScene = preload("res://Battle/MonsterBattler.tscn")
const SKELETON = preload("res://Battle/Monster/Skeleton_Sword.tres")

var game_system: GameSys = null


func before_each():
	game_system = GameSys.new()


func after_each():
	game_system.free()


func test_attack_missed():
	# arrange
	seed(1)
	var attacker: Battler = MonsterScene.instantiate()
	attacker.set_name("myName")
	attacker.set_creature(SKELETON.to_creature_stats())
	add_child(attacker)

	var defender: Battler = MonsterScene.instantiate()
	defender.set_creature(SKELETON.to_creature_stats())
	defender.set_hit_points(5)
	defender.set_armor_class(20)
	add_child(defender)

	# act
	game_system.attack(attacker, defender)

	# assert
	assert_eq(defender.get_hit_points(), 5, "Should have same number of hit points when attack misses")

	# tear down
	attacker.free()
	defender.free()


func test_attack_hit():
	## arrange
	seed(1000)
	var damage = Damage.new()
	damage.number_of_dice = 1
	damage.die = DiceBox.Die.D6
	var weapon = WeaponResource.new()
	weapon.damage = damage
	
	var attacker: Battler = MonsterScene.instantiate()
	attacker.set_creature(SKELETON.to_creature_stats())
	attacker.set_creature_name("myName")
	attacker.set_action(weapon)
	add_child(attacker)

	var defender: Battler = MonsterScene.instantiate()
	defender.set_creature(SKELETON.to_creature_stats())
	defender.set_hit_points(10)
	defender.set_armor_class(10)
	add_child(defender)

	# act
	game_system.attack(attacker, defender)

	# assert
	assert_eq(defender.get_hit_points(), 5, "Should hit points reduced by damage when attack hits")

	# tear down
	attacker.free()
	defender.free()
	get_node("HitEffect").free()
