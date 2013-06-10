class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :number
  after_save :add_to_soulmate
  before_destroy :remove_from_soulmate

  def self.search(name)
    contacts = Soulmate::Matcher.new("contact").matches_for_term(name)
    contacts.collect { |c| { "id" => c["id"], "name" => c["term"], "number" => c["data"]["number"], "email" => c["data"]["email"] } }
  end

  private

  def add_to_soulmate
    loader = Soulmate::Loader.new("contact")
    loader.add("term" => name, "id" => self.id, "data" => { "number" => number, "email" => email })
  end

  def remove_from_soulmate
    loader = Soulmate::Loader.new("contact")
    loader.remove("id" => self.id)
  end
end
