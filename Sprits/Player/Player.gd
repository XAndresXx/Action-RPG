extends KinematicBody2D

const acceleration=500
const max_speed=80
const friction=500

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state=MOVE
var velocity=Vector2.ZERO

onready var animationPlayer=$AnimationPlayer
onready var animationTree=$AnimationTree
onready var animationState=animationTree.get("parameters/playback")

func _ready():
	animationTree.active=true

func _physics_process(delta):
	match state:
		MOVE:
			Move_state(delta)
		ROLL:
			pass
		ATTACK:
			Attack_state(delta)
	

func Move_state(delta):
	var input_vector=Vector2.ZERO
	input_vector.x=Input.get_action_raw_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y=Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector=input_vector.normalized()#Nos moveremos en la misma velocidad en cualquier direccion
	if input_vector!=Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position",input_vector)
		animationTree.set("parameters/Run/blend_position",input_vector)
		animationTree.set("parameters/Attack/blend_position",input_vector)
		animationState.travel("Run")
		velocity=velocity.move_toward(input_vector*max_speed,acceleration*delta)
	else:
		animationState.travel("Idle")
		velocity=velocity.move_toward(Vector2.ZERO,friction*delta)
	velocity=move_and_slide(velocity)
	if Input.is_action_just_pressed("attack"):
		state=ATTACK

func Attack_state(delta):
	velocity=Vector2.ZERO
	animationState.travel("Attack")
	

func Attack_animation_finished():
	state=MOVE
