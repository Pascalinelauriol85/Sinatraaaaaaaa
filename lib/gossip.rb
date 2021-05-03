# Cette classe me sert a réaliser toutes les méthodes 
class Gossip

  attr_accessor :author, :content

# j'initialise mes variables  
  def initialize(author, content) 
    @author = author
    @content = content
  end

# méthode pour sauvegarder, on crée un tableau avec le nom de la personne et son potin  
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author , content]
    end
  end

  # Je rassemble la totalité des nom et potins dans le hash all_gossips
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  # je pars à la recherche de l'index demande dans l'url par exemple le gossip 2
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

  # Je met le nouveau gossip dans le tableau et je remet tous les autres dans le tableau et je met le nouveau tableau dans csv
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

