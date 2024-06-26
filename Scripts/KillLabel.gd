# Di KillLabel.gd

extends Label

func _ready():
	# Hapus koneksi sinyal di sini, tidak lagi diperlukan
	text = "Kill: 0"

func update_kill_count(new_count):
	text = "Kill: %s" % new_count
