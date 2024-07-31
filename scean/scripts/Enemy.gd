extends CharacterBody2D

var direction = 1
var SPEED = 100 # eller en annen passende verdi

@onready var ray_cast_down_left = $RayCastDownLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var area2D = $Area2D

func _ready():
	ray_cast_down_left.add_exception(get_parent().get_node("CharacterBody2D"))
	ray_cast_down_right.add_exception(get_parent().get_node("CharacterBody2D"))
	ray_cast_right.add_exception(get_parent().get_node("CharacterBody2D"))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Direction before checks: ", direction)
	
	# Sjekk for kollisjon med vegg

	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
		print("Colliding with right. New direction: ", direction)
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		print("Colliding with left. New direction: ", direction)

	# Sjekk for stup
	if direction == 1 and not ray_cast_down_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if direction == -1 and not ray_cast_down_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		print("no way")
		
	var thing=ray_cast_down_left.get_collider() as TileMap
	if thing:
		var hit_pos = ray_cast_down_left.get_collision_point()
		var tile_pos = thing.local_to_map(hit_pos)
		var tile_id = thing.get_cell_source_id(0, tile_pos)
		print(hit_pos)
	# Flytt fienden
	position.x += direction * SPEED * delta
	set_position(position)
	print("Position after update: ", position.x)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		Values.score = 0
		get_tree().call_deferred("reload_current_scene")

