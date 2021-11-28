require "./lib/visitor.rb"

describe Visitor do
  subject { described_class.new(name: "Miyesier") }

  it "is ecpected to have a :name on initialize" do
    expect(subject.name).not_to be nil
    expect(subject.name).to eq "Miyesier"
  end
  it "is expected to raise an error if no name is set" do
    #如果没有名字就显示出错
    expect { described_class.new }.to raise_error(RuntimeError, "A name is required")
  end
end
