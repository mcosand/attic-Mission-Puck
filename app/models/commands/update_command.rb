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

    if (self.data['keys']) then
      @model.assign_attributes(self.data['keys'], :without_protection => true)
    end

    val = @model.save
    if (val && self.reference != @model.id) then self.reference = @model.id end
    val
  end
end
