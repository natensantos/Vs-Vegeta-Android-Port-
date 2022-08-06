local allowCountdown = false
local xx = 520;
local yy = 450;
local xx2 = 820;
local yy2 = 600;
local xofs = 20;
local yofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function noteMiss()
    health = getProperty('health')
        if getProperty('health') > 0 then
        setProperty('health', health- 0.15);
        end
end
function onUpdate()
    if getProperty('curBeat') == 229 or getProperty('curBeat') == 284 then
        followchars = false;
    end
    if getProperty('curBeat') == 248 or getProperty('curBeat') == 289 then
        followchars = true;
    end
    if getProperty('curBeat') == 303 then
        xofs = 24;
        yofs = 24;
    end
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-xofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+xofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-yofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+yofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-xofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+xofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-yofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+yofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-xofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+xofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-yofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+yofs)
            end
	    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end

local reverseTime = false
didskip = false

function onCreatePost()
	if getProperty('startingSong') == true then
        makeLuaText('skip', 'Press Space to Skip Intro', 1270, 0, 200);
        addLuaText('skip');
        setTextSize('skip', 30)
        doTweenAlpha('skipfuera','skip',0,3,'linear')
    end
end

function onUpdatePost()
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not getProperty('startingSong') and didskip == false then
            didskip = true
			removeLuaText('skip');
            setPropertyFromClass('Conductor', 'songPosition', 5000) -- it is counted by milliseconds, 1000 = 1 second
            setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
            setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
    end
	if curStep > 79 then
	reverseTime = true
	didskip = true
end
end