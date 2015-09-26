--configureation for Love2D!

function love.conf(t)
    t.window.width = 1024
    t.window.height = 768

    t.window.borderless = true        -- Remove all border visuals from the window (boolean)
    t.window.resizable = false         -- Let the window be user-resizable (boolean)
    t.window.minwidth = 1              -- Minimum window width if the window is resizable (number)
    t.window.minheight = 1      
end