package;

import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
	override public function new(x:Float, y:Float, note:Int)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas("noteSplashes");

		animation.addByPrefix("01", "note impact 1 purple", 24, false);
		animation.addByPrefix("02", "note impact 2 purple", 24, false);
		animation.addByPrefix("11", "note impact 1 blue", 24, false);
		animation.addByPrefix("12", "note impact 2 blue", 24, false);
		animation.addByPrefix("21", "note impact 1 green", 24, false);
		animation.addByPrefix("22", "note impact 2 green", 24, false);
		animation.addByPrefix("31", "note impact 1 red", 24, false);
		animation.addByPrefix("32", "note impact 2 red", 24, false);

		offset.x = width * 0.35;
		offset.y = height * 0.35;
	}
}
