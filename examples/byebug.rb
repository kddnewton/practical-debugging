class User
  def birthday
    @age = (@age || 26) + 1
  end

  def next_5_years
    5.times do
      birthday
      puts @age
    end
  end
end

User.new.next_5_years
