extends KinematicBody2D

var xx
export var jump_speed = 800
export var speed = 80
export var velocity = Vector2()
export var gravity = 400
var off = 20
var viewport
var txt
var hit = false
var targ
onready var lab = get_node("Camera2D/TextureRect/Label")
onready var collider = get_node("CollisionShape2D")
onready var cam = get_node("Camera2D")
onready var menu = get_parent().get_node("Pause_canvas/Pause")


func _ready():
	viewport = get_viewport_rect().size
	xx = viewport.x/2
	position = Vector2(viewport.x/2,viewport.y/1.10)
	txt = get_parent().get_node("Player/Camera2D/TextureRect/Label")
	
	
func _process(delta):
	var cam_pos = cam.get_camera_position()
	if abs(cam_pos.y - position.y) >= viewport.y/2:
		self.visible = false
		menu.dead = true
	
	
	
	var mouse_pos = get_global_mouse_position()
	var acc = Input.get_accelerometer()

	if position.x < -off:
		position.x = viewport.x + off
	elif position.x > viewport.x + off:
		position.x = -off
	
	raycast(collider.shape,collision_mask)
	
	if hit:
		if sign(velocity.y) >= 0:
			velocity.x = 0
			velocity.y = -jump_speed
		hit = false
	else:
		velocity.y += gravity * delta * 4
	
	if Settings.a_meter:
		velocity = Vector2(speed * acc.x, velocity.y)
	#lab.text = str(velocity.x)
	else:
		get_input()
		
	velocity = move_and_slide(velocity, Vector2(0,-1))
	#if Input.is_mouse_button_pressed(BUTTON_LEFT):
		#velocity.y = -jump_speed
		
		
func _input(event):
	if event is InputEventKey:
		#if event.pressed and event.scancode == KEY_D:
			#menu.dead = true
			
		if event.pressed and event.scancode == KEY_R:
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()
			
			
func get_input():
	if Input.is_action_pressed('ui_right'):
		velocity = Vector2(speed * 3 , velocity.y)
	if Input.is_action_pressed('ui_left'):
		velocity = Vector2(speed * -3 , velocity.y)
	
	
	
func raycast(rect,mask):
	var ray_lenght = 20
	var ray_count = 4
	var space_state = get_world_2d().direct_space_state
	var extents = rect.extents - Vector2(1,1)
	var spacing = extents.x *2/(ray_count - 1)
	var origin
	var exceptions = [self]
	var direction = Vector2(0,1)
	var cast_to = ray_lenght * direction
	for i in range(ray_count):
		origin = Vector2(-extents.x + spacing * i,extents.y)
		var xx = self.position + origin
		var yy = self.position + origin + cast_to
		var result = space_state.intersect_ray(xx ,yy,exceptions,mask)
		if result:
			hit = true
			targ = result.position
