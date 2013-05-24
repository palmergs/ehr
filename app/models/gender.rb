module Gender
  FEMALE = 'F'
  MALE = 'M'
  FEMALE_TO_MALE = 'F2M'
  MALE_TO_FEMALE = 'M2F'

  ALL_GENDER = [ FEMALE, MALE, FEMALE_TO_MALE, MALE_TO_FEMALE ]
  ALL_GENDER_FOR_SELECT = [
    [ 'Female', FEMALE ], 
    [ 'Male', MALE ], 
    [ 'Female to Male', FEMALE_TO_MALE ], 
    [ 'Male to Female', MALE_TO_FEMALE ] ].freeze

  ALL_GENDER_FOR_LOOKUP = ALL_GENDER_FOR_SELECT.inject({}) do |hash, arr| 
    hash[arr[1]] = arr[0] 
    hash
  end.freeze

  def long_gender 
    if self.gender
      ALL_GENDER_FOR_LOOKUP[self.gender]
    end
  end
end
