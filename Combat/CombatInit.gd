class_name CombatInit
extends RefCounted

const Character = preload("res://Combat/Character.tscn")
const Monster = preload("res://Combat/Monster.tscn")
const Item = preload("res://Combat/Item.tscn")

const STEP = 16


func create_characters(combat: Node2D, dictionaries: Array) -> Array:
	var characters = []
	for i in range(dictionaries.size()):
		var x = i + 1
		var character = create_character(dictionaries[i], Vector2(x, 1))
		characters.append(character)
		combat.add_child(character)
	return characters


func create_character(dictionary: Dictionary, position: Vector2) -> Character:
	var character = Character.instantiate()
	var texture = load(dictionary["texture_file"])
	character.get_node("Sprite2D").texture = texture
	character.position = position * STEP

	var creature : Creature = character.get_creature()
	creature.set_name(dictionary["name"])
	creature.set_damage(1)

	return character


func create_monsters(combat: Node2D, monster_resources: Array[MonsterResource]) -> Array[Monster]:
	var monsters: Array[Monster] = []
	var i = 3
	for monster_resource in monster_resources:
		var position = Vector2(i, 3)
		var monster = create_monster(monster_resource, position)
		monster.attacked.connect(combat._on_Monster_attacked)
		monsters.append(monster)
		combat.add_child(monster)
		i += 1
	return monsters


func create_monster(monster_resource: MonsterResource, position: Vector2) -> Monster:

	var monster = Monster.instantiate()
	monster.set_texture(monster_resource.texture)
	monster.position = position * STEP

	var creature = monster.get_creature()
	creature.set_name(monster_resource.name)
	creature.set_hit_points(monster_resource.hit_points)
	creature.set_armor_class(monster_resource.armor_class)
	creature.got_hurt.connect(monster._on_Creature_got_hurt)

	return monster


func create_items(combat: Node2D, itemEntries: Array) -> Array:
	var items = []
	for itemEntry in itemEntries:
		var frame_coords = itemEntry["frame_coords"]
		var position = itemEntry["position"]
		var item = create_item(frame_coords, position)
		items.append(item)
		combat.add_child(item)
	return items


func create_item(frame_coords: Vector2, position: Vector2) -> ItemArea2D:
	var item = Item.instantiate()
	item.set_frame_coords(frame_coords)
	item.position = position * STEP
	return item
