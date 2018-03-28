DklBaseGraphics = DklBaseGraphics or {}

require "dbg/DklAxis"

function wrange(data)
	local total = 0
	local maxv = data[1]
	local minv = data[1]
	for i=1,#data do
		total= total+data[i]
		if(total > maxv)then
			maxv = total	
		end
		if(total<minv)then
			minv=total
		end
	end
	return {minv,maxv}
end

function DklBaseGraphics:waterfall(x,y,args)
	args = args or {}
	
	local pch = args.pch or self.plt.pch
	local tpch = type(pch) == "table"
	local _pch = pch

	local cex = args.cex or self.plt.cex
	local tcex = type(cex) == "table"
	local _cex = cex
	
	local col = args.col or self.plt.col
	local tcol = type(col) == "table"
	
	local bg = args.bg or self.plt.bg
	local tbg = type(bg) == "table"
	local lwd = args.lwd or self.plt.lwd
	local tlwd = type(lwd) == "table"
	local _tmp
	local  yVal
	local accum = 0
	local bottom = false
	pushMatrix()
	translate(self.fig.xoff,self.fig.yoff)
	translate(self.plt.xoff,self.plt.yoff)
	translate(-self.plt.usr[1]*self.plt.xscl,self.plt.usr[3]*self.plt.yscl)
	
	noFill()
	_tmp = not tcol and stroke(col)
	_tmp = not tbg and pch > 14 and fill(bg)
	_tmp = not tlwd and strokeWeight(lwd)
	if(args.mode == "ver")then
		for i=1,#x do
			_cex = tcex and cex[(i-1)%#cex+1] or _cex
			_pch = tpch and pch[(i-1)%#pch+1] or _pch
			_tmp = tcol and fill(col[(i-1)%#col+1])
			_tmp = tbg and _pch > 14 and fill(bg[(i-1)%#bg+1])
			_tmp = tlwd and strokeWeight(lwd[(i-1)%#tlwd+1])
			if(y[i] < 0)then
						fill("#ff2020")
						if(bottom)then
							yVal = (-y[i]*self.plt.yscl)
							accum = accum - yVal
							rect(x[i]*self.plt.xscl,y[i]*self.plt.yscl-accum,0.3*self.plt.xscl,yVal)
							bottom = true
						else
							yVal = (-y[i]*self.plt.yscl)
							accum = accum - yVal
							rect(x[i]*self.plt.xscl,y[i]*self.plt.yscl-accum,0.3*self.plt.xscl,yVal)
							bottom = true
						end
			else
						fill("#2020ff")
						if(bottom)then
							yVal = (y[i]*self.plt.yscl)
							rect(x[i]*self.plt.xscl,-y[i]*self.plt.yscl-accum,0.3*self.plt.xscl,yVal)
							accum = accum + yVal
							bottom = false
						else
							yVal = (y[i]*self.plt.yscl)
							rect(x[i]*self.plt.xscl,-y[i]*self.plt.yscl-accum,0.3*self.plt.xscl,yVal)
							accum = accum + yVal
							bottom = false
						end
			end
		end
	else
		for i=1,#y do
			_cex = tcex and cex[(i-1)%#cex+1] or _cex
			_pch = tpch and pch[(i-1)%#pch+1] or _pch
			_tmp = tcol and fill(col[(i-1)%#col+1])
			_tmp = tbg and _pch > 14 and fill(bg[(i-1)%#bg+1])
			_tmp = tlwd and strokeWeight(lwd[(i-1)%#tlwd+1])
			if(x[i] < 0)then
						if(_tmp == false or _tmp == nil)then
							fill("#ff2020")
						end
						if(bottom)then
							xVal = (-x[i]*self.plt.xscl)
							accum = accum - xVal
							rect(0+accum,-(y[i])*self.plt.yscl,xVal,0.3*self.plt.yscl)
							bottom = true
						else
							xVal = (-x[i]*self.plt.xscl)
							accum = accum - xVal
							rect(0+accum,-(y[i])*self.plt.yscl,xVal,0.3*self.plt.yscl)
							bottom = true
						end
			else
						if(_tmp == false or _tmp == nil)then
							fill("#2020ff")
						end
						if(bottom)then
							xVal = (x[i]*self.plt.xscl)
							rect(0+accum,-(y[i])*self.plt.yscl,xVal,0.3*self.plt.yscl)
							accum = accum + xVal
							bottom = false
						else
							xVal = (x[i]*self.plt.xscl)
							rect(0+accum,-(y[i])*self.plt.yscl,xVal,0.3*self.plt.yscl)
							accum = accum + xVal
							bottom = false
						end
			end
		end
	end
	fill(0)
	popMatrix()
end
