extends GutTest

const texture1 = preload("res://Assets/graphics/sprites/Fighter.png")
const texture2 = preload("res://Assets/graphics/sprites/Skeleton.png")

var combat_init: CombatInit = null

func before_each():
	combat_init = CombatInit.new()


func test_can_create_CombatInit():
	# act
	var my_combat_init = CombatInit.new()

	# assert
	assert_not_null(my_combat_init)


func test_create_character():

	# arrange
	var character_dictionary = {
		name = "myName",
		texture_file = "res://Assets/graphics/sprites/Fighter.png"
	}

	# act
	var character = combat_init.create_character(character_dictionary, Vector2(2, 2))

	# assert
	assert_eq(character.get_node("Sprite2D").texture, texture1, "Should have given texture")
	assert_eq(character.position, Vector2(32, 32), "Should have correct position")
	var creature = character.get_creature()
	assert_eq(creature.get_name(), "myName", "Should set correct name")
	assert_eq(creature.get_damage(), 1, "Should set damage to one")

	# tear down
	character.free()


func test_create_characters():
	# arrange
	var combat = Node2D.new()

	# act
	var characters = combat_init.create_characters(combat, [
			{ name = "Character 0", texture_file = "res://Assets/graphics/sprites/Fighter.png" },
			{ name = "Character 1", texture_file = "res://Assets/graphics/sprites/Mage.png" },
		])

	# assert
	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
	assert_eq(characters[0].position, Vector2(16, 16), "Should place 1st charater at (16, 16)")
	assert_eq(characters[0].get_creature().get_name(), "Character 0", "Should name 1st charater with Character 0")
	assert_eq(characters[1].get_creature().get_movement(), 4, "Should set movement of 1st charater")

	assert_eq(characters[1].position, Vector2(32, 16), "Should place 2nd charater at (32, 16)")
	assert_eq(characters[1].get_creature().get_name(), "Character 1", "Should name 2nd charater with Character 1")
	assert_eq(characters[1].get_creature().get_movement(), 4, "Should set movement of 2st charater")

	# tear down
	for character in characters:
		character.free()
	combat.free()



func test_create_monster():
	# arrange
	var monster_resource = MonsterResource.new()
	monster_resource.name = "Skeleton"
	monster_resource.hit_points = 2
	monster_resource.armor_class = 10
	monster_resource.texture = texture2

	# act
	var monster = combat_init.create_monster(monster_resource, Vector2(3, 3))

	# assert
	assert_eq(monster.get_node("AnimatedSprite2D").sprite_frames, texture2, "Should have given texture")
	assert_eq(monster.position, Vector2(48, 48), "Should place monster at (48, 48)")
	var creature = monster.get_creature()
	assert_eq(creature.get_name(), "Skeleton", "Should set name to Skeleton")
	assert_eq(creature.get_hit_points(), 2, "Should set hit points to 2")
	assert_eq(creature.get_armor_class(), 10, "Should set armor class to 10")

	# tear down
	monster.free()


func test_create_monsters():
	# arrange
	var combat = Combat.new()
	var skeleton = MonsterResource.new()
	var skeleton_chief = MonsterResource.new()

	# act
	var monsters = combat_init.create_monsters(combat, [ skeleton, skeleton_chief ])

	# assert
	assert_eq(monsters.size(), 2, "Should create one monster for each given texture")
	assert_eq(monsters[0].position, Vector2(48, 48), "Should place 1st monster at (48, 48)")
	assert_eq(monsters[1].position, Vector2(64, 48), "Should place 2nd monster at (64, 48)")

	# tear down
	for monster in monsters:
		monster.free()
	combat.free()


func test_create_items():
	# arrange
	var combat = Combat.new()

	# act
	var items = combat_init.create_items(combat, [
		{ frame_coords = Vector2(2, 30), position = Vector2(9, 4) },
		{ frame_coords = Vector2(2, 30), position = Vector2(10, 11) },
	])

	# assert
	assert_eq(items.size(), 2, "Should create two items")
	assert_eq(items[0].position, Vector2(144, 64), "Should place first item at (144, 64)")
	assert_eq(items[1].position, Vector2(160, 176), "Should place second item at (160, 176)")

	# tear down
	for item in items:
		item.free()
	combat.free()


func test_create_item():
	# arrange
	var frame_coords = Vector2(2, 30)
	var position = Vector2(9, 4)

	# act
	var item = combat_init.create_item(frame_coords, position)

	# assert
	assert_eq(item.position, Vector2(144, 64), "Should set proper position")

	# tear down
	item.free()

