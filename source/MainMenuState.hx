package;

#if desktop import Discord.DiscordClient; #end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;

using StringTools;
class MainMenuState extends MusicBeatState {
	#if !switch var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', 'options'];
	#else var optionShit:Array<String> = ['story mode', 'freeplay']; #end

	var curSelected:Int = 0;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var bgDesat:FlxSprite;
	var camFollow:FlxObject;
	override function create() {
		#if desktop DiscordClient.changePresence("In the Menus", null); #end
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;
		persistentUpdate = persistentDraw = true;
		if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('freakyMenu'));

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, 0.18);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
		bg.antialiasing = true;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		bgDesat = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bgDesat.scrollFactor.set(0, 0.18);
		bgDesat.setGraphicSize(Std.int(bgDesat.width * 1.1));
		bgDesat.updateHitbox();
		bgDesat.screenCenter();
		bgDesat.color = 0xFFfd719b;
		add(bgDesat);
		bgDesat.visible = false;
		bgDesat.antialiasing = true;

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length) {
			var menuItem:FlxSprite = new FlxSprite(0, 60 + (i * 160));
			menuItem.frames = Paths.getSparrowAtlas('FNF_main_menu_assets');
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}
		FlxG.camera.follow(camFollow, null, 0.06);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "v" + Application.current.meta.get('version'), 12);
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.scrollFactor.set();
		add(versionShit);

		changeItem();
		super.create();
	}

	var selectedSomethin:Bool = false;
	override function update(elapsed:Float) {
		if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		if (!selectedSomethin) {
			if (controls.UP_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			} if (controls.DOWN_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}
			if (controls.BACK) FlxG.switchState(new TitleState());
			if (controls.ACCEPT) {
				if (optionShit[curSelected] == 'donate') {
					#if linux Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
					#else FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
					#end
				} else {
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(bgDesat, 1.1, 0.15, false);
					menuItems.forEach(function(spr:FlxSprite) {
						if (curSelected != spr.ID) FlxTween.tween(spr, {alpha: 0}, 0.4, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween) {spr.kill();}});
						else {
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker) {
								var daChoice:String = optionShit[curSelected];
								switch (daChoice) {
									case 'story mode':
										FlxG.switchState(new StoryMenuState());
										trace("selected story mode");
									case 'freeplay':
										FlxG.switchState(new FreeplayState());
										trace("selected freeplay");
									case 'options':
										FlxTransitionableState.skipNextTransIn = true;
										FlxTransitionableState.skipNextTransOut = true;
										FlxG.switchState(new OptionsMenu());
								}
							});
						}
					});
				}
			}
		}
		super.update(elapsed);
		menuItems.forEach(function(spr:FlxSprite){spr.screenCenter(X);});
	}

	function changeItem(huh:Int = 0) {
		curSelected += huh;
		if (curSelected >= menuItems.length) curSelected = 0;
		if (curSelected < 0) curSelected = menuItems.length - 1;
		menuItems.forEach(function(spr:FlxSprite) {
			spr.animation.play('idle');
			if (spr.ID == curSelected) {
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}
			spr.updateHitbox();
		});
	}
}