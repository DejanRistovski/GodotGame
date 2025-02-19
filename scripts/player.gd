extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var state = "idle"
var can_move = false
@onready var pivot: Node3D = $CameraOrigin
@export var sens = 0.2
@onready var animation_player: AnimationPlayer = $Model/AnimationPlayer

func update_animation():
	if state == "run":
		animation_player.play("run/Root|Run")
	elif state == "jump":
		animation_player.play("jump/Root|Jump")
	else:
		animation_player.play("idle/Root|Idle")

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if !can_move:
		return
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
		
	if !can_move:
		return
	
	if state != "jump":
		state = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor() and state == "jump":
		state = "idle"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#animation_player.play("jump/Root|Jump")
		state = "jump"
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if state != "jump":
			state = "run"
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	update_animation()
	move_and_slide()
