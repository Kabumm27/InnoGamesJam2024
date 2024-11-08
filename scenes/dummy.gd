extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionHorizontal := Input.get_axis("move_left", "move_right")
	if directionHorizontal:
		velocity.x = directionHorizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var directionVertical := Input.get_axis("move_up", "move_down")
	if directionVertical:
		velocity.y = directionVertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)


	move_and_slide()
