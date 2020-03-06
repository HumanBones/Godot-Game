extends KinematicBody2D


export var velocity = Vector2()
var off = 20
var viewport
export var speed = 100
onready var lab = get_node("Label")

func _ready():
	viewport = get_viewport_rect().size
	position = Vector2(viewport.x/2,viewport.y/1.5)
	
	
# warning-ignore:unused_argument
func _process(delta):

	var acc = Input.get_accelerometer()
	
	
	#Screen overlap

	if position.x < -off:
		position.x = viewport.x + off
	elif position.x > viewport.x + off:
		position.x = -off
	if position.y > viewport.y + off:
		position.y = 0
	elif position.y <= 0:
		position.y = viewport.y
		
	#Movment
	
	velocity = Vector2(speed*acc.x, -speed * acc.y)
	velocity = move_and_slide(velocity, Vector2(0,-1))
