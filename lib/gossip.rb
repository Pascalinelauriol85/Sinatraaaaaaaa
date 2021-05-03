
class Gossip

  attr_accessor :author, :content

# j'initialise mes mes variables  
  def initialize(author, content) 
    @author = author
    @content = content
  end

# méthode pour sauvegarder, on crée un tableau   
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author , content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    gossip = []
    CSV.read("./db/gossip.csv").each_with_index  do |csv_line,index|
      if id == index+1
        gossip << Gossip.new(csv_line[0], csv_line[1])
        break
      end
    end
    return gossip
  end

  def self.update(id,author,content)
    gossips=[]
    CSV.read('./db/gossip.csv').each_with_index do |csv_line, index|
      if id.to_i == index + 1
        gossips << [author,content]
      else
        gossips << [csv_line[0],csv_line[1]]
      end
    end
    CSV.open('./db/gossip.csv', 'w') do |csv|
      gossips.each {|gossip| csv << gossip}  
    end
  end

end

