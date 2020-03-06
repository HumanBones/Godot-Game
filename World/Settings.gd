extends Node

var high_score = 0
var data_file = "user://data.json"
var local_data_file = "user://local_data.save"
var score_list = []
var a_meter = true
var hscore = false
var username
var p_visible = true
var data
var date
var time
var username_good = false
var local_good = false


func _ready():
	var acc = Input.get_accelerometer()
	load_json_data()
	load_data_file()
	get_os_time()
	#if acc == Vector3():
	#	a_meter = false
	#	print("no Acc")
	#else:
	#	a_meter = true
		
func get_os_time():
	var date_raw = OS.get_date()
	date = date_raw
	var time_raw =  OS.get_time()
	time = time_raw

func save_score(score):
	if score > high_score:
		hscore = true
		high_score = score
		save_json_data()
		print("Hscore")
		print(high_score)
	else:
		hscore = false
		print("score")
		
	if score != 0 and not score in score_list:
		score_list.append(score)
		score_list.sort()
		score_list.invert()
		var list_size = score_list.size()
		if list_size > 10:
			score_list.pop_back()
		#save_score_file()
		

func load_data_file():
	var f = File.new()
	if f.file_exists(local_data_file ):
		local_good = true
		f.open(local_data_file , File.READ)
		local_data_file = f.get_var()
		f.close()

func save_data_file():
	var f = File.new()
	f.open(local_data_file ,File.WRITE)
	f.store_var(score_list,username)
	f.close()

func save_json_data():
	#data[username] = high_score
	var user_data = {
		'username': username,
		'high_score' : high_score,
		'date' : date,
		'time' : time
	}
	data.append(user_data)
	var f = File.new()
	f.open(data_file,File.WRITE)
	f.store_string(to_json(data))
	f.close()

func load_json_data():
	var f = File.new()
	if f.file_exists(data_file):
		f.open(data_file, File.READ)
		data = f.get_line()
		data = parse_json(data)
		f.close()
	else:
		data = []
