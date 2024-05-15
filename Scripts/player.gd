extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_collision_shape_2d = $Area2D/AreaCollisionShape2D
@onready var body_collision_shape_2d = $BodyCollisionShape2D
@onready var lv1_dialogue = $"../Boss_LV_1/Dialogue"

@export_group("Locomotion")
@export var run_speed_damping = 2.2
@export var speed = 100.0
@export var jump_velocity = -350
@export_group("")

@export_group("CameraSync")
@export var camera_sync = Camera2D
@export var should_camera_sync: bool = true
@export_group("")

func _process(delta):
	if global_position.x > camera_sync.global_position.x && should_camera_sync:
		camera_sync.global_position.x = global_position.x
	if global_position.x < camera_sync.global_position.x && should_camera_sync:
		camera_sync.global_position.x = global_position.x
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= .5
		
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = lerp(velocity.x, speed * direction, run_speed_damping * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
	
	animated_sprite_2d.trigger_animation(velocity, direction)
	
	move_and_slide()

func _on_too_close_area_area_entered(area):
	velocity.x = 0
	velocity.y = 0
	speed = 0
	jump_velocity = 0
	lv1_dialogue.fill_questionary("first_boss")
	lv1_dialogue.visible = !lv1_dialogue.visible
