extends Camera2D




func _ready():
	var pos = get_viewport_rect().size
	self.limit_left = 0
	self.limit_right = pos.x
	self.drag_margin_bottom = 1.5
