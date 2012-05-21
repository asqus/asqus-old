class Rep < ActiveRecord::Base
  belongs_to :user
  
  def self.find_by_latlong(lat, long)
    logger.info 'Looking up rep for ' + lat.to_s + ' ' + long.to_s

    state = self.find_state_reps_by_latlong(lat, long)
    federal = self.find_federal_reps_by_latlong(lat, long)
    state.merge(federal)
  end
  
  def self.find_state_reps_by_latlong(lat, long)
    GovKit::OpenStates
    results = GovKit::OpenStatesResource.get_uri('/legislators/geo?', :query => {:lat => lat, :long => long})
    representatives = Hash.new
    results.each{ |rep|
      representatives[rep.chamber + ' ' + rep.district] = rep.full_name
    }
    representatives
  end
  
  
  def self.find_federal_reps_by_latlong(lat, long)
    federal = Sunlight::Legislator.all_for(:latitude => lat, :longitude => long)
    representatives = Hash.new
    federal.each{ |rep|
      full_name = rep[1].firstname + ' ' + rep[1].lastname
      representatives[rep[1].govtrack_id] = full_name
    }
    representatives
  end
  
end
