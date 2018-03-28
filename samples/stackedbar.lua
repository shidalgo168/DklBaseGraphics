--
-- stackedbar.lua
--
-- Döiköl Base Graphics Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "dbg/DklBaseGraphics"

local bg
local x
local y
local col
local total = 0
local maxValue = 0

function setup()
	size(500,350)
	local f = loadFont("data/Karla.ttf",12)
	textFont(f)
	bg = DklBaseGraphics:new(width(),height())
	
	x = {0,1,2,3,4,5}
	y = {{0,0,0},{11,8,10},{14,10,7},{8,6,6},{14,14,11},{9,8,6}}
	col = {"#20ff20","#ff2020","#2020ff"}
end

function draw()
	background(255)
	

	bg:plot(x,y,{type="s",col=col,bty="n",main="stackedbar.lua",sub="Stacked bar example",xlab="X axis",ylab="Y axis"})
end

function windowResized(w,h)
	bg:resize_window(w,h)
end
