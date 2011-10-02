require "happymapper"

class AbilityScoreNumber
	include HappyMapper
	tag :AbilityScoreNumber
	element :Name, String
	attribute :FinalValue, Integer

end

class AbilityScoreValues
	include HappyMapper
	tag :Values
	has_many :AbilityScoreNumber, AbilityScoreNumber, :deep => true
end


class AbilityScores
	include HappyMapper
	tag :AbilityScores
	has_one :Values, AbilityScoreValues
end


class Monster
	include HappyMapper
	tag :Monster
	element :Level, Integer
	element :Experience, Integer
	element :CompendiumUrl, String
	element :Name, String
	element :IsLeader, Boolean
	has_one :AbilityScores, AbilityScores
	

end

if File.exists?("Goblin.xml")
	monster = Monster.parse(File.read("Goblin.xml"))
else 
print "File did not exist"
end



print monster.Name + "\n"

monster.AbilityScores.Values.AbilityScoreNumber.each do |score|
	print score.Name + ":" + score.FinalValue.to_s + "\n"
end