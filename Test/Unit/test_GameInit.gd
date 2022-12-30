extends GutTest

const texture1 = preload("res://World/Knight_01.png")
const texture2 = preload("res://World/Knight_02.png")


func test_can_create_GameInit():
	# act
	var game_init = GameInit.new()
	
	# assert
	assert_not_null(game_init)


func test_create_character():
	# arrange
	var game_init = GameInit.new()	
	
	# act
	var character = game_init.create_character("myName", texture1, Vector2(64, 64))

	# assert
	assert_eq(character.get_node("Sprite").texture, texture1, "Should have given texture")
	assert_eq(character.position, Vector2(64, 64), "Should have correct position")
	assert_eq(character.scale, Vector2(0.5, 0.5), "Should set scale to (0.5, 0.5)")
	var creature = character.get_creature()
	assert_eq(creature.get_name(), "myName", "Should set correct name")
	assert_eq(creature.get_damage(), 1, "Should set damage to one")

	
func test_create_characters():
	# arrange
	var game_init = GameInit.new()
	
	# act
	var characters = game_init.create_characters([texture1, texture2])
	
	# assert
	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
	assert_eq(characters[0].position, Vector2(32, 32), "Should place 1st charater at (32, 32)")
	assert_eq(characters[0].get_creature().get_name(), "Character 0", "Should name 1st charater with Character 0")
	
	assert_eq(characters[1].position, Vector2(64, 32), "Should place 2nd charater at (64, 32)")
	assert_eq(characters[1].get_creature().get_name(), "Character 1", "Should name 2nd charater with Character 1")


func test_create_monster():
	# arrange
	var game_init = GameInit.new()
	
	# act
	var monster = game_init.create_monster()
	
	# assert
	assert_eq(monster.position, Vector2(96, 96), "Should place monster at (96, 96)")
	assert_eq(monster.scale, Vector2(0.5, 0.5), "Should place scale monster with (0.5, 0.5)")
	var creature = monster.get_creature()
	assert_eq(creature.get_name(), "Goblin", "Should set name to Goblin")
	assert_eq(creature.get_hit_points(), 2, "Should set hit points to 2")
	assert_eq(creature.get_armor_class(), 10, "Should set armor class to 10")
	
	
func test_create_monsters():
	# arrange
	var game_init = GameInit.new()
	
	# act
	var monsters = game_init.create_monsters()
	
	# assert
	assert_eq(monsters.size(), 1, "Should create one monster")
