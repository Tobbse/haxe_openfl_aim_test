import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.MouseEvent;

class App extends Sprite {
	public function new() {
		super();
	}

	static function main () {
		var stage = new Stage(Game.WIDTH, Game.HEIGHT, 0x00FFFF, App);
		stage.addChild(new Game());

		js.Browser.document.body.appendChild(stage.element);
	}
}