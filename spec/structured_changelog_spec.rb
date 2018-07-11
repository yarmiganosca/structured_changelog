require 'pathname'

RSpec.describe StructuredChangelog do
  let(:changelog_file) { Pathname.new(__FILE__)/'..'/'CHANGELOG.md' }
  subject(:changelog)  { StructuredChangelog.new(changelog_file) }

  describe "#version" do
    it "is the version number in the first RELEASE block" do
      expect(changelog.version).to eq Gem::Version.new("0.10.0")
    end
  end

  describe "#roadmap" do
    it 'contains all the versions in the ROADMAP blocks' do
      versions = changelog.roadmaps.map(&:version).
        select { |version| Gem::Version.new("") < version }.
        compact.sort

      expect(versions).to eq %w(100.0.0 100.0.1).map(&Gem::Version.method(:new))
    end
  end
end
