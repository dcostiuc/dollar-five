function love.conf(t)
    t.window.title = "$5" -- "Five Dollars ($5)"
    -- t.window.icon = ".../…"

    t.window.width = 800
    t.window.height = 600

    t.window.borderless = false -- true? - consider having a fake "loading" window for a few secs with the Love logo or saying something like Made With LÖVE

    -- t.window.fullscreen = true
    t.window.fullscreentype = "desktop" -- consider experimenting with this and "exclusive"

    t.version = "11.3"

    -- Could consider disabling any that I don’t need/use
    -- t.modules.audio = true
    --  ....
end
