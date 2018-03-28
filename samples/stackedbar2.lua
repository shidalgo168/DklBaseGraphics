--
-- stackedbar2.lua
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
	
	x = {0,1,2,3,4}
	y = {{0,0,0},{3.2,3.7},{2.66,4},{4,4.4},{3.4,4}}
	col = {"#e08020","#00402f"}
end

function draw()
	background(255)
	

	bg:plot(y,x,{type="s",col=col,bty="n",main="stackedbar2.lua",sub="Horizontal example",xlab="X axis",ylab="Y axis"})
end

function windowResized(w,h)
	bg:resize_window(w,h)
end