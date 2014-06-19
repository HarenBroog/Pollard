class Number
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Fixnum

  field :p,     type: Fixnum
  field :q,     type: Fixnum

  field :np,      type: Fixnum
  field :number_of_tries, type: Fixnum
  field :console, type: String
end
