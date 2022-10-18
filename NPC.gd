extends Area2D
var active = false

func _ready():
	connect("body_entered",self,"enter")
	connect("body_exited",self,"out")

func _process(delta):
	$Question.visible = active

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_accept") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('time1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end',self, 'unpause')
			dialog.connect("dialogic_signal", self, 'dialogic_signal')
			add_child(dialog)

func unpause(_timeline_name):
	get_tree().paused = false

func enter(body):
	if body.name == "jugador":
		active = true

func out(body):
	if body.name == "jugador":
		active = false
