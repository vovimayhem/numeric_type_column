class Location < ActiveRecord::Base
  #belongs_to :type, class_name: :LocationType
  attr_accessible :name
  
  has_numeric_sti_column :type_id,
    inheritance_map: {
      1   => 'StreetAddress',
      2   => 'Route',
      3   => 'Intersection',
      4   => 'Political',
      5   => 'Country',
      6   => 'AdministrativeAreaLevel1',
      7   => 'AdministrativeAreaLevel2',
      8   => 'AdministrativeAreaLevel3',
      9   => 'ColloquialArea',
      10  => 'Locality',
      11  => 'Sublocality',
      12  => 'Neighborhood',
      13  => 'Premise',
      14  => 'Subpremise',
      15  => 'PostalCode',
      16  => 'NaturalFeature',
      17  => 'Airport',
      18  => 'Park',
      19  => 'PointOfInterest',
      20  => 'PostBox',
      21  => 'StreetNumber',
      22  => 'Floor',
      23  => 'Room',
      24  => 'Zone',
      25  => 'Establishment'
    }
  def type_string
    self.class.name.demodulize.underscore
  end
end
