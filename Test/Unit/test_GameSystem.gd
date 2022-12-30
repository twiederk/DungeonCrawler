extends GutTest

var game_system: GameSystem = null


func before_each():
	game_system = GameSystem.new()
	
	
func after_each():
	game_system.free()
	
		
func test_attack_missed():
	# arrange
	var attacker: Creature = double(Creature).new()
	stub(attacker, 'roll_attack').to_return(1)
	
	var defender: Creature = Creature.new()
	defender.set_hit_points(5)
	defender.set_armor_class(10)
	
	# act
	game_system.attack(attacker, defender)
	
	# assert
	assert_eq(defender.get_hit_points(), 5, "Should have same number of hit points when attack misses")
	

func test_attack_hit():
	# arrange
	var attacker: Creature = double(Creature).new()
	stub(attacker, 'roll_attack').to_return(10)
	stub(attacker, 'get_damage').to_return(2)
	
	var defender: Creature = Creature.new()
	defender.set_hit_points(5)
	defender.set_armor_class(10)
	
	# act
	game_system.attack(attacker, defender)
	
	# assert
	assert_eq(defender.get_hit_points(), 3, "Should hit points reduced by damage when attack hits")
	


