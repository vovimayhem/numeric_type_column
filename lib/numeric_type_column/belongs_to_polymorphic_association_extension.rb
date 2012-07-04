# Patch para permitir polymorphs con columna foreign_type numerica:

# TODO: Revisar si se puede llamar el folder 'active_record' sin problemas de nombre.
require 'active_record/associations/belongs_to_polymorphic_association'

module NumericTypeColumn
  # = Active Record Belongs To Polymorphic Association
  module BelongsToPolymorphicAssociationExtension
    def do_like_a_duck
      "Quak!"
    end
  end
end