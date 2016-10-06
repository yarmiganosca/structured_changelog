require 'pathname'

RSpec.describe StructuredChangelog do
  let(:changelog_file) { Pathname.new(__FILE__)/'..'/'..'/'changelog.md' }
  subject(:changelog)  { StructuredChangelog.new(changelog_file) }

  describe "#version" do
    it "is the versions number in the first RELEASE block" do
      expect(changelog.version).to eq "0.1.0"
    end
  end
end
