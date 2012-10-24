class UnsignedColumnsTest < ActiveRecord::Base
  belongs_to :references_unsigned_column
  attr_accessible :boolean_unsigned_column, :decimal_unsigned_column, :integer_unsigned_column, :unsigned_float_column
end
