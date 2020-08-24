import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;

class Game extends Sprite {
	public static var WIDTH = 1600;
	public static var HEIGHT = 900;
	public static var CIRCLES_TO_CLICK = 30;

	var _circle:Sprite;
	var _lastClickTime:Float = 0;
	var _totalClickTime:Float = 0;
	var _numClicked:Int = 0;

	public function new() {
		super();
		mouseChildren = true;
		mouseEnabled = true;
		_update();
	}

	function _onCircleClicked(event:MouseEvent) {
		_update();
		_addScore();
	}

	function _update() {
		_removeCircle();

		if (_isGameFinished()) _showFinalScore();
		else _addCircle();
	}

	function _removeCircle() {
		if (_circle == null) return;

		removeChild(_circle);
		_circle.removeEventListener(MouseEvent.CLICK, _onCircleClicked);
		_circle = null;
	}

	function _addScore() {
		var currentTime = Date.now().getTime();

		if (_lastClickTime == 0) _lastClickTime = currentTime;

		_totalClickTime += currentTime - _lastClickTime;
		_lastClickTime = currentTime;
		_numClicked++;
	}

	function _addCircle() {
		_circle = new Sprite();
		_circle.mouseChildren = true;
		_circle.mouseEnabled = true;
		_circle.addEventListener(MouseEvent.MOUSE_DOWN, _onCircleClicked);
		
		var radius = 40;
		var xPos = radius / 2 + Std.random(WIDTH - radius);
		var yPos = radius / 2 + Std.random(HEIGHT - radius);

		_circle.graphics.beginFill(0xFF0000, 1);
        _circle.graphics.drawCircle(xPos, yPos, radius);
        _circle.graphics.endFill();

		trace("Added circle at (" + xPos + "|" + yPos + ").");
		addChild(_circle);
	}

	function _isGameFinished():Bool {
		return _numClicked > CIRCLES_TO_CLICK;
	}

	function _showFinalScore() {
		var scoreTf = new TextField();
        scoreTf.text = "Time needed for " + CIRCLES_TO_CLICK + " circles: " + _totalClickTime + " (ms)";
		scoreTf.border = true;
		scoreTf.width = 250;
		scoreTf.height = 30;
		scoreTf.scaleX = 3;
		scoreTf.scaleY = 3;
		scoreTf.x = (WIDTH - scoreTf.width) / 2;
		scoreTf.y = (HEIGHT - scoreTf.height) / 2;
        addChild(scoreTf);
	}
}