class_name GameInit
extends Reference

const Character = preload("res://World/Character.tscn")
const Monster = preload("res://World/Monster.tscn")


func create_characters(textures: Array) -> Array:
	var characters = []
	for i in range(textures.size()):
		var name = str("Character ", i)
		var x = (i + 1) * 32
		var character = create_character(name, textures[i], Vector2(x, 32))
		characters.append(character)
	return characters


func create_character(name: String, texture: Texture, position: Vector2) -> Character:
	var character = Character.instance()
	character.get_node("Sprite").texture = texture
	character.position = position
	character.scale = Vector2(0.5, 0.5)
	
	var creature : Creature = character.get_creature()
	creature.set_name(name)
	creature.set_damage(1)

	return character


func create_monsters() -> Array:
	return [create_monster()]
	

func create_monster() -> Monster:
	var monster = Monster.instance()
	monster.position = Vector2(96, 96)
	monster.scale = Vector2(0.5, 0.5)

	var creature = monster.get_creature()
	creature.set_name("Goblin")
	creature.set_hit_points(2)
	creature.set_armor_class(10)
	
	return monster


