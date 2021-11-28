require "./lib/book.rb"

describe Book do
  subject { Book.new }

  it "is expected to have an return date on initialize" do #预计初始化有一个到期信息
    return_date = Date.today.next_month(1).strftime("%Y-%m-%d")
    expect(subject.rtn_date).to eq return_date
  end

  it "is expected to have :active status on initialize" do #设置账户最初的时候这个账户就应该是:active状态
    expect(subject.book_status).to eq :active
  end
end
