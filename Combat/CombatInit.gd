class_name CombatInit
extends RefCounted

const CharacterScene = preload("res://Combat/Character.tscn")
const MonsterScene = preload("res://Combat/Monster.tscn")
const ItemScene = preload("res://Combat/Item.tscn")


func create_characters(combat: Node, dictionaries: Array) -> Array[Battler]:
	var characters: Array[Battler] = []
	for i in range(dictionaries.size()):
		var x = i + 1
		var character = create_character(dictionaries[i], Vector2(x, 1))
		character.battler_died.connect(combat._on_battler_died)
		character.battler_attacked.connect(combat._on_battler_attacked)
		character.turn_ended.connect(combat.next_battler)
		
		combat.add_child(character)
		var sprite_frames = load(dictionaries[i]["sprite_frames"])
		character.set_sprite_frames(sprite_frames)
		characters.append(character)
	return characters


func create_character(dictionary: Dictionary, position: Vector2) -> Character:
	var character = CharacterScene.instantiate()
	character.position = position * Combat.TILE_SIZE
	character.name = dictionary["name"]

	character.set_creature_name(dictionary["name"])
	character.set_hit_points(dictionary["hit_points"])
	character.set_damage(dictionary["damage"])
	character.set_armor_class(dictionary["armor_class"])
	return character


func create_monsters(combat: Node, monster_resources: Array[MonsterResource]) -> Array[Battler]:
	var monsters: Array[Battler] = []
	var x = 3
	for monster_resource in monster_resources:
		var position = Vector2(x, 3)
		var monster = create_monster(monster_resource, position)
		monster.battler_died.connect(combat._on_battler_died)
		monster.battler_attacked.connect(combat._on_battler_attacked)
		monster.turn_ended.connect(combat.next_battler)
		
		combat.add_child(monster)
		monster.set_sprite_frames(monster_resource.texture)
		monsters.append(monster)
		x += 1
	return monsters


func create_monster(monster_resource: MonsterResource, position: Vector2) -> Monster:

	var monster = MonsterScene.instantiate()
	monster.position = position * Combat.TILE_SIZE
	monster.name = monster_resource.name

	monster.set_creature_name(monster_resource.name)
	monster.set_hit_points(monster_resource.hit_points)
	monster.set_damage(monster_resource.damage)
	monster.set_armor_class(monster_resource.armor_class)

	return monster


func create_items(combat: Combat, itemEntries: Array) -> Array:
	var items = []
	for itemEntry in itemEntries:
		var frame_coords = itemEntry["frame_coords"]
		var position = itemEntry["position"]
		var item = create_item(frame_coords, position)
		items.append(item)
		combat.add_child(item)
	return items


func create_item(frame_coords: Vector2, position: Vector2) -> ItemArea2D:
	var item = ItemScene.instantiate()
	item.set_frame_coords(frame_coords)
	item.position = position * Combat.TILE_SIZE
	return item
