package;

#if desktop
	import Discord.DiscordClient;
	import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;
class TitleState extends MusicBeatState {
	var credGroup:FlxGroup;
	var textGroup:FlxGroup; // not sure what these 2 are for ngl

	var curWacky:Array<String> = []; // introtext shenanigans
	var newgroundsLogo:FlxSprite;

	var logo:FlxSprite;
	var girlfriend:FlxSprite;
	var titleText:FlxSprite;
	
	var danceLeft:Bool = false;
	var initialized:Bool = false;
	override public function create():Void {
		PlayerSettings.init();
		curWacky = FlxG.random.getObject(getIntroTextShit());
		super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');
		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null) {
			if (StoryMenuState.weekUnlocked.length < 4) StoryMenuState.weekUnlocked.insert(0, true);
			if (!StoryMenuState.weekUnlocked[0]) StoryMenuState.weekUnlocked[0] = true;
		}

		#if desktop
			DiscordClient.initialize();
			Application.current.onExit.add(function(exitCode) {DiscordClient.shutdown();});
		#end

		girlfriend = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		girlfriend.frames = Paths.getSparrowAtlas('gfDanceTitle');
		girlfriend.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		girlfriend.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		add(girlfriend);
		girlfriend.antialiasing = true;

		logo = new FlxSprite(-150, -100);
		logo.frames = Paths.getSparrowAtlas('logoBumpin');
		logo.animation.addByPrefix('bump', 'logo bumpin', 24);
		logo.animation.play('bump');
		add(logo);
		logo.antialiasing = true;
		logo.updateHitbox();

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.animation.play('idle');
		add(titleText);
		titleText.antialiasing = true;
		titleText.updateHitbox();

		credGroup = new FlxGroup();
		add(credGroup);

		textGroup = new FlxGroup();

		var blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		newgroundsLogo = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		newgroundsLogo.setGraphicSize(Std.int(newgroundsLogo.width * 0.8));
		add(newgroundsLogo);
		newgroundsLogo.visible = false;
		newgroundsLogo.antialiasing = true;
		newgroundsLogo.updateHitbox();
		newgroundsLogo.screenCenter(X);

		new FlxTimer().start(1, function(tmr:FlxTimer) {startIntro();});
	}

	function startIntro() {
		if (!initialized) {
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1), {asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(6, 0, 0.7);
		}

		Conductor.changeBPM(102);
		persistentUpdate = true; // ???

		FlxG.mouse.visible = false;
		if (initialized) skipIntro();
		else initialized = true;
	}

	function getIntroTextShit():Array<Array<String>> {
		var fullText:String = Assets.getText(Paths.txt('introText'));
		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];
		for (i in firstArray) swagGoodArray.push(i.split('--'));
		return swagGoodArray;
	}

	var transitioning:Bool = false;
	override function update(elapsed:Float) {
		if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;
		if (FlxG.keys.justPressed.F) FlxG.fullscreen = !FlxG.fullscreen;
		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
			for (touch in FlxG.touches.list) {
				if (touch.justPressed) pressedEnter = true;
			}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		if (gamepad != null) {
			if (gamepad.justPressed.START) pressedEnter = true;

			#if switch
				if (gamepad.justPressed.B) pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro) {
			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			titleText.animation.play('press');
			transitioning = true;
			new FlxTimer().start(2, function(tmr:FlxTimer) {FlxG.switchState(new MainMenuState());});
		}

		if (pressedEnter && !skippedIntro) skipIntro();
		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>) {
		for (i in 0...textArray.length) {
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String) {
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText() {
		while (textGroup.members.length > 0) {
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit() {
		super.beatHit();
		logo.animation.play('bump');
		danceLeft = !danceLeft;
		if (danceLeft) girlfriend.animation.play('danceRight');
		else girlfriend.animation.play('danceLeft');

		switch (curBeat) {
			case 1: createCoolText(['ninjamuffin99', 'phantomArcade', 'kawaisprite', 'evilsk8er']);
			case 3: addMoreText('present');
			case 4: deleteCoolText();
			case 5: createCoolText(['In association', 'with']);
			case 7:
				addMoreText('newgrounds');
				newgroundsLogo.visible = true;
			case 8:
				deleteCoolText();
				newgroundsLogo.visible = false;
			case 9: createCoolText([curWacky[0]]);
			case 11: addMoreText(curWacky[1]);
			case 12: deleteCoolText();
			case 13: addMoreText('Friday');
			case 14: addMoreText('Night');
			case 15: addMoreText('Funkin');
			case 16: skipIntro();
		}
	}

	var skippedIntro:Bool = false;
	function skipIntro():Void {
		if (!skippedIntro) {
			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(newgroundsLogo);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}