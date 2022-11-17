class Batch::DataReset
  def self.data_reset
    user = User.find_by(email: "guestuse07r@example.com")
    user.post_coffees.destroy_all
    user.coffee_comments.destroy_all
    user.favorites.destroy_all
  end
end