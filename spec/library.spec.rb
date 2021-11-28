require "./lib/library.rb"

RSpec.describe Library do
  after(:each) do
    test_data = YAML.load_file("./spec/test_data.yml")
    File.open("./lib/data.yml", "w") { |file| file.write(test_data.to_yaml) }
  end

  describe "instance methods" do
    it { is_expected.to respond_to(:books) }
    it { is_expected.to respond_to(:search) }
    it { is_expected.to respond_to(:checkout) }
  end

  it "is expected to have a collection of books as an array" do #Ruby 数组是任何对象的有序整数索引集合。数组中的每个元素都与一个索引相关，并可通过索引进行获取。
    #数组的索引从 0 开始，所以yaml 中的书名想要在pry or irb 中寻找所以一定要从[0]开始找因为0 是第一本书
    expect(subject.books).to be_instance_of Array
  end

  it "is expected to hold 4 books" do
    expect(subject.books.size).to eq 4
  end

  describe "a book" do
    it "is expected to have a availibily status" do
      expect(subject.books.first.keys).to include("available")
    end
    it "is expected to have a return date" do
      expect(subject.books.first.keys).to include("return_date")
    end
  end

  describe "#search" do #可查找书及查找时书的状态
    describe "using title" do #在寻找书的时候从书名开始找
      it "is expected to return one object" do
        book = subject.search("Lord of the flies")
        expected_result = {
          :book => {
            :title => "Lord of the flies",
            :author => "William Golding",
          },
          "available" => true,
          "return_date" => "",
        }
        expect(book).to eq(expected_result)
      end
    end
  end

  describe "#checkout" do #代表图书馆书及状态
    let(:person) { instance_double("Person", book_shelf: []) }

    before do
      @book = subject.search("Lord of the flies")
      subject.checkout(@book, person)
    end

    it "is expected to set availability to false" do
      expect(@book["available"]).to eq false
    end

    it "is expected to set return date to today + 30 days" do
      expected_return_date = Date.today.next_month.strftime("%Y-%m-%d")
      expect(@book["return_date"]).to eq expected_return_date
    end

    it "is expected to add book to persons book shelf" do
      expect(person.book_shelf).to include @book
    end

    describe "the book in memory" do #书的历史记录
      before do
        @book = subject.books.detect { |object| object[:book][:title] == "Lord of the flies" }
      end

      it "is expected to be updeted with new availability" do
        expect(@book["available"]).to eq false
      end

      it "is expected to be updeted with new return date" do
        expect(@book["return_date"]).to_not eq ""
      end
    end

    describe "is storage" do #图书馆书的储存状态 上面上面借出去了所以下面是状态是false
      before do
        books = YAML.load_file("./lib/data.yml")
        @book = books.detect { |object| object[:book][:title] == "Tuesdays with Morrie" }
      end
      it "is expected ti be updeted with new availability" do
        expect(@book["available"]).to eq false
      end
      it "is expected ti be updeted with new return date" do
        expect(@book["return_date"]).to_not eq ""
      end
    end
  end
end
