-- npclocations.lua

--[[ 
Eksempel på NPC-model, som kan kopieres og indsættes:
{
    model = "mp_m_freemode_01", -- NPC model (mandlig freemode)
    coords = vector3(0.0, 0.0, 0.0), -- Placering af NPC
    heading = 0.0, -- Retning NPC'en kigger
    clothing = {
        components = {
            [1] = {variation = 0, texture = 0}, -- Masker
            [3] = {variation = 0}, -- Arme
            [4] = {variation = 0, texture = 0}, -- Bukser
            [5] = {variation = 0}, -- Tasker
            [6] = {variation = 0}, -- Sko
            [7] = {variation = 0}, -- Tilbehør
            [8] = {variation = 0, texture = 0}, -- T-Shirts
            [9] = {variation = 0}, -- Skudsikre veste
            [10] = {variation = 0}, -- Patches
            [11] = {variation = 0, texture = 0} -- Jakker
        },
        props = {
            [0] = {drawable = -1}, -- Hat
            [1] = {drawable = -1, texture = 0}, -- Briller
            [2] = {drawable = -1} -- Øreringe
        }
    },
    animation = {
        enabled = false, -- Sæt til true for at aktivere animation
        dict = "", -- Animationens dictionary
        name = "", -- Animationens navn
        flag = 1 -- Animation flag (standard 1)
    },
    skinType = 0, -- Hudtype (0 = standard)
    skinColor = 0 -- Hudfarve (0 = standard)
}
]]


return {
    {
        model = "mp_m_freemode_01", -- Mandlig freemode-model
        coords = vector3(424.89, -1020.54, 28.97),
        heading = 94.01,
        clothing = {
            components = {
                [1] = {variation = 0, texture = 0}, -- Masker
                [3] = {variation = 12}, -- Arme
                [4] = {variation = 193, texture = 0}, -- Bukser
                [5] = {variation = 0}, -- Tasker
                [6] = {variation = 25}, -- Sko
                [7] = {variation = 0}, -- Tilbehør
                [8] = {variation = 122, texture = 0}, -- T-Shirts
                [9] = {variation = 0}, -- Skudsikre veste
                [10] = {variation = 0}, -- Patches
                [11] = {variation = 526, texture = 5} -- Jakker
            },
            props = {
                [0] = {drawable = 216}, -- Hat
                [1] = {drawable = 5, texture = 0}, -- Briller
                [2] = {drawable = -1} -- Øreringe
            }
        },
        animation = {
            enabled = true,
            dict = "amb@world_human_leaning@male@wall@back@legs_crossed@base",
            name = "base",
            flag = 1 -- Standard flag
        },
        skinType = 1, -- Tilføjet hudtype for denne NPC
        skinColor = 1 -- Tilføjet hudfarve for denne NPC
    },
    {
        model = "mp_m_freemode_01", -- Mandlig freemode-model
        coords = vector3(424.57, -1021.64, 28.94),
        heading = 74.05,
        clothing = {
            components = {
                [1] = {variation = 0, texture = 0}, -- Masker
                [3] = {variation = 12}, -- Arme
                [4] = {variation = 193, texture = 0}, -- Bukser
                [5] = {variation = 0}, -- Tasker
                [6] = {variation = 25}, -- Sko
                [7] = {variation = 0}, -- Tilbehør
                [8] = {variation = 122, texture = 0}, -- T-Shirts
                [9] = {variation = 66}, -- Skudsikre veste
                [10] = {variation = 0}, -- Patches
                [11] = {variation = 526, texture = 5} -- Jakker
            },
            props = {
                [0] = {drawable = 216}, -- Hat
                [1] = {drawable = 5, texture = 0}, -- Briller
                [2] = {drawable = -1} -- Øreringe
            }
        },
        animation = {
            enabled = true,
            dict = "amb@world_human_stand_guard@male@idle_a",
            name = "idle_a",
            flag = 1 -- Standard flag
        },
        skinType = 2, -- Tilføjet hudtype for denne NPC
        skinColor = 2 -- Tilføjet hudfarve for denne NPC
    }
}
