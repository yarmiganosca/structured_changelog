require 'pathname'

RSpec.describe StructuredChangelog do
  let(:changelog_file) { Pathname.new(__FILE__)/'..'/'changelog.md' }
  subject(:changelog)  { StructuredChangelog.new(changelog_file) }

  describe "#version" do
    it "is the versions number in the first RELEASE block" do
      expect(changelog.version).to eq "0.2.0"
    end
  end

  describe "#roadmap_versions" do
    it 'contains all the versions in the ROADMAP blocks' do
      expect(changelog.roadmap_versions).to eq %w(100.0.0 100.0.1)
    end
  end
end
