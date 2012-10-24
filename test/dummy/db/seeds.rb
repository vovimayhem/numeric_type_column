[
  { 
    :integer_unsigned_column => 1, 
    :integer_signed_column => -1,
    :string_column => "Prueba 1",
    :decimal_unsigned_column => 66.669,
    :unsigned_float_column => 33.334,
    :boolean_unsigned_column => false,
    :references_unsigned_column_id => 23
  },
  { 
    :integer_unsigned_column => -1, 
    :integer_signed_column => -1,
    :string_column => "Prueba 2",
    :decimal_unsigned_column => -66.669,
    :unsigned_float_column => -33.334,
    :boolean_unsigned_column => false,
    :references_unsigned_column_id => -23
  }
].each { |attrs| UnsignedColumnsTest.where(attrs).first_or_create }
