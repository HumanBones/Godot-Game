extends Control

onready var butt = get_node("Button")
onready var popout = get_node("AcceptDialog")
onready var input = get_node("AcceptDialog/LineEdit")
onready var p_dialog = get_node("CanvasLayer/PopupDialog")




func _ready():
	var presistent = OS.is_userfs_persistent()
	print(presistent)
	get_tree().set_quit_on_go_back(false)
	butt.margin_bottom = -(rect_size.y*0.1)
	#Settings.load_score_file()
	p_dialog.popup_exclusive = false
	if Settings.p_visible:
		popout.popup()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		Settings.save_json_data()
		get_tree().quit()

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	if Settings.username_good:
		get_tree().change_scene("res://World/World.tscn")
	

func _on_ReportBug_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("https://humanbones.xyz/report/")


func _text_entered():
	var input_text = input.get_text()
	var values = Settings.data
	var val = []
	for i in values:
		val.append(i.get('username'))

	if input_text.empty():
		print("empty")
		
	elif val.has(input_text):
		print('name taken')
		p_dialog.show()
		popout.visible = false
		
	else:
		Settings.username = input_text
		print(input_text)
		popout.visible = false
		Settings.p_visible = false
		Settings.username_good = true
	

func _on_AcceptDialog_confirmed():
	_text_entered()


func _on_Scoreboard_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scoreboard/Scoreboard.tscn")


func _input(event):
	if p_dialog.visible:
		if event is InputEventMouseButton or event is InputEventKey or event is InputEventScreenTouch:
			print(event)
			p_dialog.hide()
			popout.visible = true
		elif event is InputEventMouseMotion:
			pass
