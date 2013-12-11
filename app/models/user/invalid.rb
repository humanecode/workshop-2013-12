class User
  class Invalid
    include ActiveModel::Model

    attr_accessor :email, :password
    attr_reader   :errors

    def initialize email
      @email = email
      @errors = ActiveModel::Errors.new(self)
      errors.add :email,    "must be entered" if @email.blank?
      errors.add :password, "is not correct"
    end

    def self.model_name
      ActiveModel::Name.new User
    end

    def valid?;      false; end
    def new_record?; true;  end
    def persisted?;  false; end
    def destroyed?;  false; end
  end
end
