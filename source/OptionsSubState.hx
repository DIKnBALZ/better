package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Master Volume', 'Sound Volume', 'Controls', 'Gameplay', 'penis in my mouth'];

	var curSelected:Int = 0;
	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;
		if (controls.DOWN_P)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;
		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;
			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "Controls":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new ControlsSubState());
				case "Gameplay":
					FlxG.state.closeSubState();
					FlxG.state.openSubState(new GameplaySubState());
				case "penis in my mouth":
					trace('YOU CLICKED IT GAYASS');
			}
		}

		if (controls.BACK)
		{
			FlxG.state.closeSubState();
			FlxG.switchState(new MainMenuState());
		}
	}
}
