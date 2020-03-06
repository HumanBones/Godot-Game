extends Control

var pause = false
var dead = false
onready var score_saved = false
onready var fade = get_node("Fade")
onready var menu = get_node("Menu_box")
onready var p_button = get_node("Pause_box")
onready var score = get_node("../../TileMap")
onready var score_label = get_node("Menu_box/Score")
#onready var settings = get_parent().get_parent().get_node("Settings")


func _Button_pressed():
	
	if pause:
		pause = false
		get_tree().paused = false
		fade.visible = pause
		
	elif !pause:
		pause = true
		get_tree().paused = true
		fade.visible = pause
		
		
func _process(_delta):
	
	if dead:
		menu.visible = true
		get_tree().paused = true
		fade.visible = true
		p_button.visible = false
		if !null:
			if !score_saved:
				Settings.save_score(score.score)
				score_saved = true
			if Settings.hscore:
				score_label.text ="New High Score" + "\n" + str(score.score)
			else:
				score_label.text ="Score" + "\n" + str(score.score)
		else:
			print("null")

func _on_Exit_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Replay_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_Scoreboard_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scoreboard/Scoreboard.tscn")
