extends TileMap

var player = null
var to_spawn_cap = 0
var spawn_inc = 50
var last_known_spawn = 0
var origin = Vector2()
var pos = Vector2()
var safe_spawn = 6
var fairness = 4
var xx
var lx = 16
var yy
var fl = 1
var txt = null
var score



func spawn_tiles(from):
	randomize()
	var end_point = origin.y - from
	var start_point = end_point - spawn_inc
	delete_tiles(end_point)
	fl += 1
	
	if fl % 3 == 0:
		if fairness != 0:
			fairness -= 1
		platform(start_point)
	
	for i in range(start_point, end_point):
		if i % safe_spawn == 0 && i != end_point:
			var rx = rand_range(fairness, lx - fairness)
			for j in range(rx - 1, rx + 3):
				set_cell(j, i, 0)

func platform(ry):
	for i in range(xx):
		set_cell(i,ry,0)

func _ready():
	randomize()
	pos = get_viewport_rect().size
	xx = ceil(pos.x/32)
	yy = ceil(pos.y/32)
	platform(yy)
	
	txt = get_parent().get_node("Pause_canvas/Pause/Score")
	
	origin = Vector2(xx,yy)
	
	player = get_parent().get_node("Player")

func _process(delta):
	var gp = world_to_map( player.position )
	var offset = gp - origin
	score = offset.y*-1
	
	if txt != null:
		txt.set_text("Score:" + str(score))
		
		
	if abs(offset.y) + 20 >= to_spawn_cap:
		last_known_spawn = to_spawn_cap
		to_spawn_cap += spawn_inc
		spawn_tiles(last_known_spawn)

func delete_tiles(start):
	var start_pt = start + spawn_inc
	var end_pt = start_pt + spawn_inc
	for i in range(start_pt,end_pt):
		for j in range(0,xx):
			if get_cell(j,i) != -1:
				set_cell(j,i,-1)
					
				
