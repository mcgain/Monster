require "happymapper"
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

	class ReferenceObject
		def self.add_code
			include HappyMapper
			element :Name, String, :deep => true
			attribute :Description, String, :deep => true
		end
		def self.inherited(child) 
			child.send(:add_code)
		end
		def to_s
			"#{self.Name}: #{self.Description}\n"
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

	class Size < ReferenceObject
		tag :Size
	end

	class Origin < ReferenceObject
		tag :Origin
	end

  def create_class(class_name, superclass, &block)
    klass = Class.new superclass, &block
    Object.const_set class_name.to_s, klass
  end

  def deep_element(name, options={})
  	create_class(name, Object) do 
  		include HappyMapper
			tag name
			element :Name, String, :deep => true
			element :Description, String, :deep => true	
			def to_s
				"#{self.Name}: #{self.Description}"	
			end
  	end 
  	has_one name, name.to_s
  end

	class Monster
		
		include HappyMapper
		tag :Monster
		element :Level, Integer
		element :Experience, Integer
		element :CompendiumUrl, String
		element :Name, String
		element :IsLeader, Boolean
		# deep_element :Size
		has_one :Size, Size
		has_one :Origin, Origin
		has_many :AbilityScores, AbilityScores, :deep => true
		has_many :Defenses, Defenses, :deep => true
		has_many :AttackBonuses, AttackBonuses,	:deep => true
		has_many :Skills, Skills, :deep => true

		def to_s
			"Name: #{self.Name}" +
			"Level: #{self.Level}" +
			"Experience: #{self.Experience}" +
			"Ability Scores:\n #{self.AbilityScores}" +
			"Defenses:\n#{self.Defenses}" +
			"Attack Bonuses:\n #{self.AttackBonuses}" +
			"Skills:\n #{self.Skills}" +
			"Size #{self.Size}" +
			"Origin #{self.Origin}"
		end
	end

if File.exists?("Goblin.xml")
	monster = Monster.parse(File.read("Goblin.xml"))
else 
	print "File did not exist"
end

print monster

# print monster.Size.Name + 'xxx'
