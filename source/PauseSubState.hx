package;

import Script.HScript;

class PauseSubState extends MusicBeatSubstate
{
	public function new(x:Float, y:Float) {
		super();

		var script = new HScript("substates/GamePause");
		script.instance.create(x, y);
	}
}
