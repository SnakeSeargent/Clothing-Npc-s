local npcInstances = {} -- Gem referencer til aktive NPC'er

local function loadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
end

local function loadAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Wait(10)
    end
end

local function setHeadBlend(npc, headBlend)
    if not headBlend then return end
    SetPedHeadBlendData(
        npc,
        headBlend.shapeFirst or 0,
        headBlend.shapeSecond or 0,
        0,
        headBlend.skinFirst or 0,
        headBlend.skinSecond or 0,
        0,
        1.0, 1.0, 0.0,
        false
    )
end

local function setFacialFeatures(npc, features)
    if not features then return end
    for i = 1, #features do
        SetPedFaceFeature(npc, i - 1, features[i])
    end
end

-- Funktion til at ændre hudfarve (kun for freemode NPC'er)
local function setSkinColor(npc, skinColor)
    -- SetPedHeadBlendData ændrer hudfarve og hudtype
    -- skinColor skal være et tal mellem 0 og 7
    if skinColor >= 0 and skinColor <= 7 then
        SetPedHeadBlendData(
            npc, 
            0, 0, 0, -- Form (her lader vi dem være 0)
            skinColor, skinColor, 0, -- Hudfarve (brug skinColor for begge, da vi ikke mixer)
            1.0, 1.0, 0.0,
            false
        )
    end
end

-- Funktion til at ændre spillerens hudfarve
local function setPlayerSkinColor(skinColor)
    if skinColor >= 0 and skinColor <= 7 then
        local playerPed = PlayerPedId()
        SetPedHeadBlendData(
            playerPed, 
            0, 0, 0, -- Form (her lader vi dem være 0)
            skinColor, skinColor, 0, -- Hudfarve
            1.0, 1.0, 0.0,
            false
        )
    end
end

-- Funktion til at ændre NPC's hudform
local function setSkinType(npc, skinType)
    local skinValues = {
        [1] = {shapeFirst = 0, skinFirst = 0},
        [2] = {shapeFirst = 1, skinFirst = 1},
        [3] = {shapeFirst = 2, skinFirst = 2},
        [4] = {shapeFirst = 3, skinFirst = 3},
        [5] = {shapeFirst = 4, skinFirst = 4},
        [6] = {shapeFirst = 5, skinFirst = 5},
        [7] = {shapeFirst = 6, skinFirst = 6},
        [8] = {shapeFirst = 7, skinFirst = 7}
    }

    local skinData = skinValues[skinType]
    if skinData then
        SetPedHeadBlendData(
            npc,
            skinData.shapeFirst, 0, 0, -- Skift hudform baseret på skinType
            skinData.skinFirst, 0, 0,
            1.0, 1.0, 0.0,
            false
        )
    end
end

local function createNPC(npcData)
    local model = npcData.model
    local coords = npcData.coords
    local heading = npcData.heading
    local clothing = npcData.clothing
    local appearance = npcData.appearance
    local animation = npcData.animation
    local skinType = npcData.skinType -- Tilføjet skinType her
    local skinColor = npcData.skinColor -- Tilføjet skinColor her

    loadModel(model)

    local npc = CreatePed(4, GetHashKey(model), coords.x, coords.y, coords.z - 1.0, heading, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    -- Sæt tøjkomponenter
    for component, data in pairs(clothing.components) do
        SetPedComponentVariation(npc, component, data.variation, data.texture or 0, 0)
    end

    -- Sæt props (tilbehør som hatte og briller)
    for prop, data in pairs(clothing.props) do
        SetPedPropIndex(npc, prop, data.drawable, data.texture or 0, true)
    end

    -- Sæt hudform hvis skinType er angivet
    if skinType then
        setSkinType(npc, skinType)
    end

    -- Sæt hudfarve hvis skinColor er angivet
    if skinColor then
        setSkinColor(npc, skinColor)
    end

    -- Sæt hudfarve og ansigtsegenskaber
    if appearance then
        setHeadBlend(npc, appearance.headBlend)
        setFacialFeatures(npc, appearance.facialFeatures)
    end

    -- Spil animation, hvis det er aktiveret
    if animation and animation.enabled then
        loadAnimDict(animation.dict)
        TaskPlayAnim(npc, animation.dict, animation.name, 8.0, -8.0, -1, animation.flag or 1, 0, false, false, false)
    end

    return npc
end

local function removeAllNPCs()
    for _, npc in ipairs(npcInstances) do
        if DoesEntityExist(npc) then
            DeleteEntity(npc)
        end
    end
    npcInstances = {}
end

local function spawnNPCs()
    removeAllNPCs() -- Fjern eksisterende NPC'er

    -- Indlæs NPC-konfigurationer fra npclocations.lua
    local npcs = LoadResourceFile(GetCurrentResourceName(), "npclocations.lua")
    local npcConfig = assert(load(npcs))()

    -- Opret og gem referencer til NPC'er
    for _, npcData in ipairs(npcConfig) do
        local npc = createNPC(npcData)
        table.insert(npcInstances, npc)
    end
end

-- Initial spawn af NPC'er
CreateThread(function()
    spawnNPCs()
end)
