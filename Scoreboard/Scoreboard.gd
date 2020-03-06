extends Control

onready var board = get_node("VBoxContainer/RichTextLabel")
var score = Settings.score_list


func _ready():
	board.push_align(1)
	fill_board()

func fill_board():
	var i = 1
	for point in score:
		board.add_text(str(i) + '. ' + Settings.username + " : " + str(point) + "\n")
		i +=1 


func _on_Back_button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu/Menu.tscn")

func _on_Submit_button_pressed():
	Settings.save_json_data()
