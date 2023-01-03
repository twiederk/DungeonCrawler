class_name GameInit
extends Reference

const Character = preload("res://World/Character.tscn")
const Monster = preload("res://World/Monster.tscn")
const Item = preload("res://World/Item.tscn")

const STEP = 32

var _monster_dictionary: MonsterDictionary = null


func create_characters(dictionaries: Array) -> Array:
	var characters = []
	for i in range(dictionaries.size()):
		var x = i + 1
		var character = create_character(dictionaries[i], Vector2(x, 1))
		characters.append(character)
	return characters


func create_character(dictionary: Dictionary, position: Vector2) -> Character:
	var character = Character.instance()
	var texture = load(dictionary["texture_file"])
	character.get_node("Sprite").texture = texture
	character.position = position * STEP
	character.scale = Vector2(0.5, 0.5)

	var creature : Creature = character.get_creature()
	creature.set_name(dictionary["name"])
	creature.set_damage(1)

	return character


func create_monsters(dictionaries: Array) -> Array:
	var monsters = []
	for dictionary in dictionaries:
		var name = dictionary["monster"]
		var position = dictionary["position"]
		var monster = create_monster(name, position)
		monsters.append(monster)
	return monsters


func create_monster(name: String, position: Vector2) -> Monster:
	var dictionary = _monster_dictionary.get_monster(name)

	var monster = Monster.instance()
	var texture = load(dictionary["texture_file"])
	monster.set_texture(texture)
	monster.position = position * STEP
	monster.scale = Vector2(0.5, 0.5)

	var creature = monster.get_creature()
	creature.set_name(dictionary["name"])
	creature.set_hit_points(dictionary["hit_points"])
	creature.set_armor_class(dictionary["armor_class"])
	creature.connect("got_hurt", monster, "_on_Creature_got_hurt")

	return monster


func create_monster_dictionary() -> void:
	_monster_dictionary = MonsterDictionary.new()

	_monster_dictionary.add_monster({
		name = "Goblin",
		hit_points = 2,
		armor_class = 10,
		texture_file = "res://World/Goblin_01.png",
	})

	_monster_dictionary.add_monster({
		name = "Goblin Chief",
		hit_points = 3,
		armor_class = 12,
		texture_file = "res://World/Goblin_02.png",
	})


func create_items() -> Array:
	var item = Item.instance()
	item.set_frame_coords(Vector2(2, 30))
	item.position = Vector2(288, 128)
	
	var item2 = Item.instance()
	item2.set_frame_coords(Vector2(2, 30))
	item2.position = Vector2(320, 352)

	return [item, item2]
