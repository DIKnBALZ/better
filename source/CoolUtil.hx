package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];

	public static var leftKeybind:FlxKey = 65;
	public static var downKeybind:FlxKey = 83;
	public static var upKeybind:FlxKey = 87;
	public static var rightKeybind:FlxKey = 68;
	public static var downscroll:Bool = false;
	public static var ghostTapping:Bool = false;

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static function updatePrefs()
	{
		Reflect.setProperty(FlxG.save.data, "leftKeybind", leftKeybind);
		Reflect.setProperty(FlxG.save.data, "downKeybind", downKeybind);
		Reflect.setProperty(FlxG.save.data, "upKeybind", upKeybind);
		Reflect.setProperty(FlxG.save.data, "rightKeybind", rightKeybind);
		Reflect.setProperty(FlxG.save.data, "downscroll", downscroll);
		Reflect.setProperty(FlxG.save.data, "ghostTapping", ghostTapping);
	}
}
