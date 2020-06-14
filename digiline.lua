
digibuilder.digiline_effector = function(pos, _, channel, msg)

	local msgt = type(msg)
	if msgt ~= "table" then
		return
	end

	local meta = minetest.get_meta(pos)

	local set_channel = meta:get_string("channel")
	if set_channel == "" then
		-- backward compatibility with old static channel
		set_channel = "jumpdrive"
	end

	if channel ~= set_channel then
		return
	end

end


digibuilder.digiline_rules = {
	-- digilines.rules.default
	{x= 1,y= 0,z= 0},{x=-1,y= 0,z= 0}, -- along x beside
	{x= 0,y= 0,z= 1},{x= 0,y= 0,z=-1}, -- along z beside
	{x= 1,y= 1,z= 0},{x=-1,y= 1,z= 0}, -- 1 node above along x diagonal
	{x= 0,y= 1,z= 1},{x= 0,y= 1,z=-1}, -- 1 node above along z diagonal
	{x= 1,y=-1,z= 0},{x=-1,y=-1,z= 0}, -- 1 node below along x diagonal
	{x= 0,y=-1,z= 1},{x= 0,y=-1,z=-1}, -- 1 node below along z diagonal
	{x= 0,y= 1,z= 0},{x= 0,y=-1,z= 0}, -- along y above and below
}