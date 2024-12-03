--Script made by Krystal :3

--Options
local useBanners = false --Change this if you dont want to use banners
local useNoteSplashes = true --Yeah
local startFullHealth = true --Duh
local disableCamZoom = true --Yuh huh

 --------------------------------------

function onCreate()
    setProperty("skipArrowStartTween", true)

    if useBanner == true then
        precacheImage('banners/'..songName)
    end
    if startFullHealth == true then
        setHealth(2)
    end
        
end

function onCreatePost()
    middlescrollPos = {416, 528, 640, 752}
    for i = 4,7 do
        noteTweenX("positions"..i, i, middlescrollPos[i - 3], 0.001, "linear")
    end
    for i = 0,3 do
        noteTweenAlpha("byebye"..i, i, 0, 0.001, "linear")
    end

    --fixes 
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("scoreTxt.visible", false)
    setProperty('grpNoteSplashes.visible', useNoteSplashes)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('showCombo', false)
    setProperty('healthBarBG.angle', 90)
    setProperty('healthBar.angle', 90)
    screenCenter("healthBarBG", 'y')
    screenCenter("healthBar", 'y')
    setProperty("healthBarBG.x", 584)
    setProperty("healthBar.x", 584)
    setHealthBarColors("#000000")
    
    if useBanners == true then
    makeLuaSprite("banner", 'banners/'..songName, 0, 0)
    setObjectCamera("banner", 'camHUD')
    addLuaSprite("banner")
    --resizes the image if its not the correct resolution
        if getProperty("banner.width") ~= 1280 and getProperty("banner.height") ~= 720 then
            --scaleObject('banner', 1280, 720, false)
            setGraphicSize("banner", 1280, 720)
            debugPrint('works')
        end
    end

    

    

    makeLuaSprite("bg", '', 0, 0)
    makeGraphic("bg", 1280, 720, '000000')
    setProperty("bg.alpha", 0.5)
    setObjectCamera("bg", 'camHUD')
    addLuaSprite("bg")

    makeLuaSprite("bar", '', 416 - 1, 0)
    makeGraphic("bar", 444, 720, '000000')
    setProperty("bar.alpha", 0.8)
    setObjectCamera("bar", 'camHUD')
    addLuaSprite("bar")

    
    
    makeLuaText("scoreTextt", '00000000', 1280, -5, -5)
    setTextAlignment("scoreTextt", 'right')
    setTextSize("scoreTextt", 42)
    setTextFont("scoreTextt", "DigitalSerialBold.ttf")
    setTextBorder("scoreTextt", 0, "")
    addLuaText("scoreTextt")

    makeLuaText("ratingTxt", callMethodFromClass('backend.CoolUtil', 'floorDecimal', {rating*100, 2})..'0.00%', 1280, -5, 35)
    setTextAlignment("ratingTxt", 'right')
    setTextSize("ratingTxt", 26)
    setTextFont("ratingTxt", "DigitalSerialBold.ttf")
    setTextBorder("ratingTxt", 0, "")
    addLuaText("ratingTxt")


    makeLuaSprite("ratingss", 'sick', 550, 260)
    scaleObject("ratingss", 0.5, 0.5)
    setObjectCamera("ratingss", 'camHUD')
    setObjectOrder("ratingss", 11)
    addLuaSprite("ratingss")

    makeLuaText("comboCounter", '0', 1280, -10, 340)
    setTextSize("comboCounter", 40)
    setTextFont("comboCounter", "DigitalSerialBold.ttf")
    setTextAlignment("comboCounter", 'center')
    setObjectOrder("comboCounter", 10)
    addLuaText("comboCounter")

    setProperty("ratingss.alpha", 0)
    setProperty("comboCounter.alpha", 0)

    
end


function onUpdate()
    if disableCamZoom == true then
        setProperty("camZooming", false)
    end
end


function goodNoteHit(id)
    cancelTween("fade1")
    cancelTween("fade2")

    loadGraphic("ratingss", getPropertyFromGroup('notes', id, 'rating'))
    scaleObject("ratingss", 0.5, 0.35)
    screenCenter("ratingss", 'x')

    setProperty("ratingss.alpha", 1)
    doTweenY("scaleRatingY", "ratingss.scale", 0.5, 0.1, "bounceOut")
    doTweenY("scaleComboY", "comboCounter.scale", 1.1, 0.1, "bounceOut")

    setProperty("comboCounter.alpha", 1)
    setTextString("comboCounter", combo)
    runTimer("wait", 1)
end


function noteMiss() 
    setProperty("ratingss.alpha", 0)
    setProperty("comboCounter.alpha", 1)

    setTextString("comboCounter", "X")
end
function onTweenCompleted(tweenName)
    if tweenName == 'scaleRatingX' then
        doTweenY("scaleRatingBackY", "ratingss.scale", 0.5, 0.2, "circOut")
        doTweenY("scaleComboBackY", "comboCounter.scale", 1.1, 0.2, "circOut")
    end
end

function onTimerCompleted(timerName)
    if timerName == 'wait' then
        doTweenAlpha("fade1", "ratingss", 0, 0.5, "linear")
        doTweenAlpha("fade2", "comboCounter", 0, 0.5, "linear")
    end
end

function onUpdateScore()
    setTextString("ratingTxt", callMethodFromClass('CoolUtil', 'floorDecimal', {rating*100, 2})..'%')
    setTextString("scoreTextt", score)
    if score < 0 then
        setTextString("scoreTextt", "00000000")
    elseif score < 1000 then
        setTextString("scoreTextt", "00000"..score)
    elseif score < 10000 then
        setTextString("scoreTextt", "0000"..score)
    elseif score < 100000 then
        setTextString("scoreTextt", "000"..score)
    elseif score < 1000000 then
        setTextString("scoreTextt", "00"..score)
    end
end
