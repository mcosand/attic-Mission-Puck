class Commands::UpdateCommand < Commands::Command
  def model
    @model
  end

  class << self
    alias make_base make
    def make(reference, type, data)
      make_base(reference, {'type' => type, 'data' => data})
    end
  end

  def internal_execute
    objType = eval self.data['type']
    result = objType.where('id = ?', self.reference)

    if (result.empty?) then
      # object doesn't exist. Create it.
      @model = objType.new
      @model.id = self.reference
    else
      @model = result[0]
    end 

    assignable_attributes = (defined? objType.assignable_attributes) ?
                                      objType.assignable_attributes :
                                      objType.accessible_attributes

    # We've filtered down to accessible attributes (and a couple more as defined by the class)
    # Don't see a need for the protection, and it can get in our way (when using classy_enums)
    @model.assign_attributes(self.data['data'].slice(*(assignable_attributes)), :without_protection => true)

    if objType.respond_to? :related_keys then
      @model.assign_attributes(self.data['data'].slice(*(objType.related_keys)), :without_protection => true)
    end

    val = @model.save

    # If we were able to create the object, let the object create child objects
    if (val and objType.method_defined?(:create_children)) then
      child_keys = self.data['child_keys']
      val &= @model.create_children(child_keys)
      self.data['child_keys'] = child_keys
    end

    if (val && self.reference != @model.id) then self.reference = @model.id end

    raise ActiveRecord::Rollback unless val

    val
  end
end
