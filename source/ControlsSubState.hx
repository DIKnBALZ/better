package;

import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class ControlsSubState extends MusicBeatSubstate
{
	var optionArray:Array<FlxText> = [];
	var curSelected:Int = 0;
	var waitingForInput:Bool = false;
	var keyArray:Array<FlxKey> = [
		FlxG.save.data.leftKeybind == null ? CoolUtil.leftKeybind : FlxG.save.data.leftKeybind,
		FlxG.save.data.downKeybind == null ? CoolUtil.downKeybind : FlxG.save.data.downKeybind,
		FlxG.save.data.upKeybind == null ? CoolUtil.upKeybind : FlxG.save.data.upKeybind,
		FlxG.save.data.rightKeybind == null ? CoolUtil.rightKeybind : FlxG.save.data.rightKeybind
	];
	var canChangeSelection:Bool = true;
	var blockedKeys:Array<FlxKey> = [FlxKey.ENTER, FlxKey.ESCAPE, FlxKey.NONE];
	var directionArray:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

	public function new()
	{
		super();

		var left:FlxText = new FlxText(20, 20, 0, '${directionArray[0]}: ' + Std.string(keyArray[0]), 32);
		add(left);
		optionArray.insert(0, left);
		var down:FlxText = new FlxText(20, left.y + 50, 0, '${directionArray[1]}: ' + Std.string(keyArray[1]), 32);
		add(down);
		optionArray.insert(1, down);
		var up:FlxText = new FlxText(20, down.y + 50, 0, '${directionArray[2]}: ' + Std.string(keyArray[2]), 32);
		add(up);
		optionArray.insert(2, up);
		var right:FlxText = new FlxText(20, up.y + 50, 0, '${directionArray[3]}: ' + Std.string(keyArray[3]), 32);
		add(right);
		optionArray.insert(3, right);
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (controls.UP_P && canChangeSelection)
			curSelected -= 1;
		if (controls.DOWN_P && canChangeSelection)
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

		if (controls.ACCEPT)
		{
			waitingForInput = true;
			canChangeSelection = false;
			keyArray.remove(keyArray[curSelected]);
			optionArray[curSelected].text = "Waiting for input...";
		}

		if (waitingForInput)
		{
			if (!blockedKeys.contains(FlxG.keys.firstJustPressed()))
			{
				keyArray.insert(curSelected, FlxG.keys.firstJustPressed());
				optionArray[curSelected].text = '${directionArray[curSelected]}: ' + Std.string(keyArray[curSelected]);
				waitingForInput = false;
				canChangeSelection = true;
				CoolUtil.leftKeybind = keyArray[0];
				CoolUtil.downKeybind = keyArray[1];
				CoolUtil.upKeybind = keyArray[2];
				CoolUtil.rightKeybind = keyArray[3];
				CoolUtil.updatePrefs();
			}
		}

		if (controls.BACK)
		{
			CoolUtil.updatePrefs();
			FlxG.state.closeSubState();
			FlxG.state.openSubState(new OptionsSubState());
		}
	}
}
