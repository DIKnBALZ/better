package;

import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class GameplaySubState extends MusicBeatSubstate
{
	var optionArray:Array<FlxText> = [];
	var curSelected:Int = 0;
	var waitingForInput:Bool = false;
	var downscroll:FlxText;
	var ghostTapping:FlxText;
	var enableDownscroll:Bool = CoolUtil.downscroll;
	var enableGhostTapping:Bool = CoolUtil.ghostTapping;

	public function new()
	{
		super();

		downscroll = new FlxText(20, 20, 0, 'Downscroll: ${enableDownscroll}', 32);
		add(downscroll);
		optionArray.insert(0, downscroll);

		ghostTapping = new FlxText(20, downscroll.y + 50, 0, 'Ghost Tapping: ${enableGhostTapping}', 32);
		add(ghostTapping);
		optionArray.insert(1, ghostTapping);
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;
		if (controls.DOWN_P)
			curSelected += 1;

		for (option in optionArray)
		{
			if (optionArray[curSelected] == option)
			{
				option.color = FlxColor.YELLOW;
			}
			else
			{
				option.color = FlxColor.WHITE;
			}
		}

		if (curSelected < 0)
			curSelected = optionArray.length - 1;
		if (curSelected >= optionArray.length)
			curSelected = 0;

		switch (curSelected)
		{
			case 0:
				if (controls.ACCEPT)
				{
					enableDownscroll = !enableDownscroll;
					downscroll.text = 'Downscroll: ${enableDownscroll}';
					CoolUtil.downscroll = enableDownscroll;
				}
			case 1:
				if (controls.ACCEPT)
				{
					enableGhostTapping = !enableGhostTapping;
					ghostTapping.text = 'Ghost Tapping: ${enableGhostTapping}';
					CoolUtil.ghostTapping = enableGhostTapping;
				}
		}

		if (controls.BACK)
		{
			FlxG.state.closeSubState();
			FlxG.state.openSubState(new OptionsSubState());
		}
	}
}
