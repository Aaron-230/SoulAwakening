extends CanvasLayer

func _ready():
	Game.Health.connect(_changeHealth)
	Game.ChangedCoins.connect(_changeCoins)
	Game.ChangedPoints.connect(_changePoints)

func _changeHealth(NewHealth):
	$Health/HealthBar.value = float(NewHealth)

func _changeCoins(CoinsAdded):
	$Coin/Counter.text = str(CoinsAdded)

func _changePoints(PointsAdded):
	$Points.text = str(PointsAdded)
