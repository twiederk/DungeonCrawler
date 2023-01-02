extends GutTest

const texture1 = preload("res://World/Knight_01.png")
const texture2 = preload("res://World/Goblin_01.png")

var game_init: GameInit = null

func before_each():
	game_init = GameInit.new()
	

func test_can_create_GameInit():
	# act
	var my_game_init = GameInit.new()
	
	# assert
	assert_not_null(my_game_init)


func test_create_character():
	
	# arrange
	var character_dictionary = {
		name = "myName",
		texture_file = "res://World/Knight_01.png"
	}
	
	# act
	var character = game_init.create_character(character_dictionary, Vector2(2, 2))

	# assert
	assert_eq(character.get_node("Sprite").texture, texture1, "Should have given texture")
	assert_eq(character.position, Vector2(64, 64), "Should have correct position")
	assert_eq(character.scale, Vector2(0.5, 0.5), "Should set scale to (0.5, 0.5)")
	var creature = character.get_creature()
	assert_eq(creature.get_name(), "myName", "Should set correct name")
	assert_eq(creature.get_damage(), 1, "Should set damage to one")
	
	# tear down
	character.free()

	
func test_create_characters():

	# act
	var characters = game_init.create_characters([
			{ name = "Character 0", texture_file = "res://World/Knight_01.png" },
			{ name = "Character 1", texture_file = "res://World/Knight_02.png" },
		])

	# assert
	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
	assert_eq(characters[0].position, Vector2(32, 32), "Should place 1st charater at (32, 32)")
	assert_eq(characters[0].get_creature().get_name(), "Character 0", "Should name 1st charater with Character 0")

	assert_eq(characters[1].position, Vector2(64, 32), "Should place 2nd charater at (64, 32)")
	assert_eq(characters[1].get_creature().get_name(), "Character 1", "Should name 2nd charater with Character 1")
	
	# tear down
	for character in characters:
		character.free()



func test_create_monster():
	# arrange
	game_init.create_monster_dictionary()
	
	# act
	var monster = game_init.create_monster("Goblin", Vector2(3, 3))
	
	# assert
	assert_eq(monster.get_node("Sprite").texture, texture2, "Should have given texture")
	assert_eq(monster.position, Vector2(96, 96), "Should place monster at (96, 96)")
	assert_eq(monster.scale, Vector2(0.5, 0.5), "Should place scale monster with (0.5, 0.5)")
	var creature = monster.get_creature()
	assert_eq(creature.get_name(), "Goblin", "Should set name to Goblin")
	assert_eq(creature.get_hit_points(), 2, "Should set hit points to 2")
	assert_eq(creature.get_armor_class(), 10, "Should set armor class to 10")
	
	# tear down
	monster.free()
	
	
func test_create_monsters():
	# arrange
	game_init.create_monster_dictionary()
	
	# act
	var monsters = game_init.create_monsters([
		{ monster = "Goblin", position = Vector2(3, 3) },
		{ monster = "Goblin Chief", position = Vector2(4, 3) },
	])
	
	# assert
	assert_eq(monsters.size(), 2, "Should create one monster for each given texture")
	assert_eq(monsters[0].position, Vector2(96, 96), "Should place 1st monster at (96, 96)")
	assert_eq(monsters[1].position, Vector2(128, 96), "Should place 2nd monster at (128, 96)")
	
	# tear down
	for monster in monsters:
		monster.free()
	

func test_create_monster_dictionary():
	
	# act
	game_init.create_monster_dictionary()
	
	# assert
	assert_eq(game_init._monster_dictionary.size(), 2, "Should fill monster dictionary with two monsters")
