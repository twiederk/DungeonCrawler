class_name GameInit
extends Reference

const Character = preload("res://World/Character.tscn")
const Monster = preload("res://World/Monster.tscn")
const Item = preload("res://World/Item.tscn")
const LevelComplete = preload("res://World/LevelComplete.tscn")

const STEP = 32

var _monster_manual: MonsterManual = null


func create_characters(game: Node2D, dictionaries: Array) -> Array:
	var characters = []
	for i in range(dictionaries.size()):
		var x = i + 1
		var character = create_character(dictionaries[i], Vector2(x, 1))
		characters.append(character)
		game.add_child(character)
	return characters


func create_character(dictionary: Dictionary, position: Vector2) -> CharacterBody2D:
	var character = Character.instance()
	var texture = load(dictionary["texture_file"])
	character.get_node("Sprite").texture = texture
	character.position = position * STEP
	character.scale = Vector2(0.5, 0.5)

	var creature : Creature = character.get_creature()
	creature.set_name(dictionary["name"])
	creature.set_damage(1)

	return character


func create_monsters(game: Node2D, dictionaries: Array) -> Array:
	var monsters = []
	for dictionary in dictionaries:
		var name = dictionary["monster"]
		var position = dictionary["position"]
		var monster = create_monster(name, position)
		monster.connect("attacked", game, "_on_Monster_attacked")
		monsters.append(monster)
		game.add_child(monster)

	return monsters


func create_monster(name: String, position: Vector2) -> MonsterBody2D:
	var dictionary = _monster_manual.get_monster(name)

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


func create_items(game: Node2D, itemEntries: Array) -> Array:
	var items = []
	for itemEntry in itemEntries:
		var frame_coords = itemEntry["frame_coords"]
		var position = itemEntry["position"]
		var item = create_item(frame_coords, position)
		items.append(item)
		game.add_child(item)
	return items


func create_item(frame_coords: Vector2, position: Vector2) -> ItemArea2D:
	var item = Item.instance()
	item.set_frame_coords(frame_coords)
	item.position = position * STEP
	return item


func create_level_complete(game: Node2D, position: Vector2) -> LevelCompleteArea2D:
	var level_complete =  LevelComplete.instance()
	level_complete.position = position * 32
	game.add_child(level_complete)
	return level_complete


func create_monster_manual() -> void:
	_monster_manual = MonsterManual.new()

	_monster_manual.add_monster({
		name = "Goblin",
		hit_points = 2,
		armor_class = 10,
		texture_file = "res://Assets/Goblin_01.png",
	})

	_monster_manual.add_monster({
		name = "Goblin Chief",
		hit_points = 3,
		armor_class = 12,
		texture_file = "res://Assets/Goblin_02.png",
	})


