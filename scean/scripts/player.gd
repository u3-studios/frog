extends CharacterBody2D
		
@onready var animation = $animation

var JumpCount = 1

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		animation.animation = "Run"
	else:
		animation.animation = "Idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animation.animation = "Jump"

	if Input.is_action_just_pressed("respawn"):
		Values.score = 0
		get_tree().reload_current_scene()
		
		
	# Handle jump.
	if Input.is_action_just_released("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_on_floor():
		JumpCount = 1
		
	if not is_on_floor() and Input.is_action_just_pressed("ui_accept") and JumpCount > 0:
		velocity.y = JUMP_VELOCITY 
		JumpCount -= 1
		


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


	var isLeft = velocity.x < 0
	animation.flip_h = isLeft


		
