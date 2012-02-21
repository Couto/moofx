# color: A color converter. Takes a named color, hex(a), hsl(a) or rgb(a) as input, outputs rgb(a)
# author: Valerio Proietti (@kamicane) http://mad4milk.net http://mootools.net
# credits: http://mjijackson.com/2008/02/rgb-to-hsl-and-rgb-to-hsv-color-model-conversion-algorithms-in-javascript
# license: MIT

colors =
	maroon: '#800000', red: '#ff0000', orange: '#ffA500', yellow: '#ffff00', olive: '#808000'
	purple: '#800080', fuchsia: "#ff00ff", white: '#ffffff', lime: '#00ff00', green: '#008000'
	navy: '#000080', blue: '#0000ff', aqua: '#00ffff', teal: '#008080',
	black: '#000000', silver: '#c0c0c0', gray: '#808080'
	
RGBtoRGB = (r, g, b, a = 1) ->
	r = parseInt(r, 10)
	g = parseInt(g, 10)
	b = parseInt(b, 10)
	a = parseFloat(a)
	return null unless (r <= 255 and r >= 0) and (g <= 255 and g >= 0) and (b <= 255 and b >= 0) and (a <= 1 and a >= 0)
	[Math.round(r), Math.round(g), Math.round(b), a]
	
HEXtoRGB = (hex) ->
	if hex.length is 3 then hex += 'f'
	if hex.length is 4
		h0 = hex.charAt(0)
		h1 = hex.charAt(1)
		h2 = hex.charAt(2)
		h3 = hex.charAt(3)
		hex = h0 + h0 + h1 + h1 + h2 + h2 + h3 + h3
	if hex.length is 6 then hex +='ff'

	parseInt(hex.substr(i, 2), 16) / (if i is 6 then 255 else 1) for i in [0..hex.length] by 2
	
HUEtoRGB = (p, q, t) ->
	if t < 0 then t += 1
	if t > 1 then t -= 1
	if t < 1/6 then return p + (q - p) * 6 * t
	if t < 1/2 then return q
	if t < 2/3 then return p + (q - p) * (2/3 - t) * 6
	p
	
HSLtoRGB = (h, s, l, a = 1) ->
	h /= 360
	s /= 100
	l /= 100
	a /= 1
	if (h > 1 or h < 0) or (s > 1 or s < 0) or (l > 1 or l < 0) or (a > 1 or a < 0) then return null
	
	if s is 0 then r = b = g = l
	else
		q = if l < 0.5 then l * (1 + s) else l + s - l * s
		p = 2 * l - q
		r = HUEtoRGB(p, q, h + 1/3)
		g = HUEtoRGB(p, q, h)
		b = HUEtoRGB(p, q, h - 1/3)
		
	[r * 255, g * 255, b * 255, a]
	

moofx.color = (input, array) ->
	return null unless typeof input is 'string' # not a string
	input = colors[input = input.replace(/\s+/g, '')] or input
	if input.match(/^#[a-f0-9]{3,8}/) then input = HEXtoRGB(input.replace('#', ''))
	else if match = input.match(/([\d.])+/g)
		if input.match(/^rgb/) then input = match
		else if input.match(/^hsl/) then input = HSLtoRGB(match...)
		else return null # unknown number list
	else return null # no match
	return null unless input and input = RGBtoRGB(input...)
	return input if array
	input.splice(3, 1) if input[3] is 1
	"rgb#{if input.length > 3 then 'a' else ''}(#{input})"
