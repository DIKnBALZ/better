package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;
	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;
		switch (curCharacter)
		{
			case 'gf':
				frames = Paths.getSparrowAtlas('GF_assets');

				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);

				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset('cheer');
				addOffset('scared', -2, -17);
				addOffset('sad', -2, -2);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				playAnim('danceRight');
			case 'gf-christmas':
				frames = Paths.getSparrowAtlas('christmas/gfChristmas');

				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);

				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset('cheer');
				addOffset('scared', -2, -17);
				addOffset('sad', -2, -2);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				playAnim('danceRight');
			case 'gf-car':
				frames = Paths.getSparrowAtlas('gfCar');

				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');
			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('weeb/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				frames = Paths.getSparrowAtlas('DADDY_DEAREST');

				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);

				addOffset('idle');
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);

				playAnim('idle');
			case 'spooky':
				frames = Paths.getSparrowAtlas('spooky_kids_assets');

				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);
				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);

				playAnim('danceRight');
			case 'mom':
				frames = Paths.getSparrowAtlas('Mom_Assets');

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);

				playAnim('idle');
			case 'mom-car':
				frames = Paths.getSparrowAtlas('momCar');

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('Monster_Assets');
				frames = tex;

				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);

				playAnim('idle');
			case 'monster-christmas':
				frames = Paths.getSparrowAtlas('christmas/monsterChristmas');

				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);

				playAnim('idle');
			case 'pico':
				frames = Paths.getSparrowAtlas('Pico_FNF_assetss');
				flipX = true;

				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);

				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
				}
				else
				{
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
				}

				addOffset('idle');
				addOffset("singLEFT", 65, 9);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWN", 200, -70);
				addOffset("singDOWNmiss", 210, -28);
				addOffset("singUP", -29, 27);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHT", -68, -7);
				addOffset("singRIGHTmiss", -60, 41);

				playAnim('idle');
			case 'bf':
				frames = Paths.getSparrowAtlas('BOYFRIEND');
				flipX = true;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				addOffset('idle', -5);
				addOffset("singLEFT", 12, -6);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWN", -10, -50);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("singUP", -29, 27);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("hey", 7, 4);
				addOffset('scared', -4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);

				playAnim('idle');
			case 'bf-christmas':
				frames = Paths.getSparrowAtlas('christmas/bfChristmas');
				flipX = true;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singLEFT", 12, -6);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWN", -10, -50);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("singUP", -29, 27);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("hey", 7, 4);

				playAnim('idle');
			case 'bf-car':
				frames = Paths.getSparrowAtlas('bfCar');
				flipX = true;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singLEFT", 12, -6);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWN", -10, -50);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("singUP", -29, 27);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singRIGHTmiss", -30, 21);

				playAnim('idle');
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('weeb/bfPixel');
				antialiasing = false;
				flipX = true;

				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);

				addOffset('idle');
				addOffset("singLEFT");
				addOffset("singLEFTmiss");
				addOffset("singDOWN");
				addOffset("singDOWNmiss");
				addOffset("singUP");
				addOffset("singUPmiss");
				addOffset("singRIGHT");
				addOffset("singRIGHTmiss");

				setGraphicSize(Std.int(width * 6));
				width -= 100;
				height -= 100;
				updateHitbox();
				playAnim('idle');
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('weeb/bfPixelsDEAD');
				antialiasing = false;
				flipX = true;

				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				playAnim('firstDeath');
			case 'senpai':
				frames = Paths.getSparrowAtlas('weeb/senpai');
				antialiasing = false;

				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);

				addOffset('idle');
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				playAnim('idle');
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('weeb/senpai');
				antialiasing = false;

				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);

				addOffset('idle');
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				playAnim('idle');
			case 'spirit':
				frames = Paths.getPackerAtlas('weeb/spirit');
				antialiasing = false;

				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);

				addOffset('idle', -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				playAnim('idle');
			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('christmas/mom_dad_christmas_assets');

				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singLEFT", -30, 16);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN", -31, -29);
				addOffset("singDOWN-alt", -30, -27);
				addOffset("singUP", -47, 24);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singRIGHT-alt", -1, -24);

				playAnim('idle');
		}

		dance();
		if (isPlayer) { // TODO: auto offsets for if the char is both player and opponent
			flipX = !flipX;
			if (!curCharacter.startsWith('bf')) {
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;
				if (animation.getByName('singRIGHTmiss') != null) {
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
		animOffsets[name] = [x, y];

	private var danced:Bool = false;
	public function dance() {
		if (!debugMode) {
			switch (curCharacter) { // TODO: dance steps idea lol!
				case 'gf', 'gf-christmas', 'gf-car', 'gf-pixel', 'spooky':
					if (!animation.curAnim.name.startsWith('hair')) { // only effects gfs anyways lmao! 
						danced = !danced;
						if (danced) playAnim('danceRight');
						else playAnim('danceLeft');
					}
				default: playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void {
		animation.play(AnimName, Force, Reversed, Frame);
		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName)) offset.set(daOffset[0], daOffset[1]);
		else offset.set(0, 0);
		if (curCharacter == 'gf') {
			if (AnimName == 'singUP' || AnimName == 'singDOWN') danced = !danced;
			if (AnimName == 'singLEFT') danced = true;
			else if (AnimName == 'singRIGHT') danced = false;
		}
	}

	override function update(elapsed:Float) {
		if (!curCharacter.startsWith('bf')) {
			if (animation.curAnim.name.startsWith('sing')) holdTimer += elapsed;

			var dadVar:Float = 4;
			if (curCharacter == 'dad') dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001) {
				dance();
				holdTimer = 0;
			}
		}
		if (curCharacter == 'gf' && animation.curAnim.name == 'hairFall' && animation.curAnim.finished) playAnim('danceRight');
		super.update(elapsed);
	}
}
