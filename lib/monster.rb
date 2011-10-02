require "happymapper"

	# def standard_name_value
	# 	include HappyMapper
	# 	element :Name, String, :deep => true
	# 	attribute :FinalValue, Integer, :deep => true
	# end

	class StandardNameValue
		def self.add_code
			include HappyMapper
			element :Name, String, :deep => true
			attribute :FinalValue, Integer, :deep => true
		end

		def self.inherited(child) 
			child.send(:add_code)
		end

		def to_s
			"#{self.Name}: #{self.FinalValue}\n"
		end
	end

	class AbilityScores < StandardNameValue		
		tag :AbilityScoreNumber
	end

	class Defenses < StandardNameValue	
		tag :SimpleAdjustableNumber
	end
 
	class AttackBonuses < StandardNameValue	
		tag :CalculatedNumber
	end
		
	class Skills < StandardNameValue	
		tag :SkillNumber
	end

	class Monster
		include HappyMapper
		tag :Monster
		element :Level, Integer
		element :Experience, Integer
		element :CompendiumUrl, String
		element :Name, String
		element :IsLeader, Boolean
		has_many :AbilityScores, AbilityScores, :deep => true
		has_many :Defenses, Defenses, :deep => true
		has_many :AttackBonuses, AttackBonuses,	:deep => true
		has_many :Skills, Skills, :deep => true
	end

if File.exists?("Goblin.xml")
	monster = Monster.parse(File.read("Goblin.xml"))
else 
print "File did not exist"
end



print monster.Name + "\n"
print "Ability Scores\n".upcase!
monster.AbilityScores.each do |score|
	print score
end
print "Defenses\n".upcase!
monster.Defenses.each do |defense| 
	print defense.Name + ": " + defense.FinalValue.to_s + "\n"
end
print "AttackBonuses\n".upcase!
monster.AttackBonuses.each do |bonus|
	print bonus.Name + ": " + bonus.FinalValue.to_s + "\n"
end
