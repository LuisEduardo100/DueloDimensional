extends CanvasLayer

@onready var rich_text_label = $RichTextLabel
@onready var button = $HBoxContainer/Button
@onready var button_2 = $HBoxContainer/Button2
@onready var button_3 = $HBoxContainer/Button3


func fill_questionary(boss_type):
	var json = JSON.new()
	var file = "Assets/" + boss_type + "_questions.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = json.parse_string(json_as_text)

	var rng = RandomNumberGenerator.new()
	var q_index = rng.randi_range(0, len(json_as_dict) - 1)
	rich_text_label.push_color(Color(0, 0, 0))
	rich_text_label.add_text(json_as_dict[q_index]["pergunta"])
	button.text = json_as_dict[q_index]["opcoes"]["a"]
	button_2.text = json_as_dict[q_index]["opcoes"]["b"]
	button_3.text = json_as_dict[q_index]["opcoes"]["c"]
	
	button.grab_focus()

