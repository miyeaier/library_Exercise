require "yaml"
require "date"

class Library
  attr_accessor :books

  def initialize
    @books = YAML.load_file("./lib/data.yml")
  end

  def search(title)
    @books.detect { |object| object[:book][:title] == title }
  end

  def checkout(object, person)
    #set the attributes
    object["available"] = false
    object["return_date"] = Date.today.next_month.strftime("%Y-%m-%d")
    #update the persons #book_shelf
    person.book_shelf.push(object)
    File.open("./lib/data.yml", "w") { |file| file.write(@books.to_yaml) } #w 意思是write acssas

    #write to the yaml file

  end
end
