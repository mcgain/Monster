require "happymapper"

class Monster
	include HappyMapper
	tag :Monster
	element :Level, Integer
	element :Experience, Integer
	element :CompendiumUrl, String
	element :Name, String
	element :IsLeader, Boolean
end

if File.exists?("Goblin.xml")
	monster = Monster.parse(File.read("Goblin.xml"))
else 
print "File did not exist"
end

print monster.Name
