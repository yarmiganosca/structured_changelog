require 'fantaskspec'
require 'structured_changelog/tasks/sync'

RSpec.describe 'rake changelog:sync', type: :rake do
  let(:task_name) { 'changelog:sync' }
  let(:options) do
    {
      changelog_path: Pathname.new(__FILE__)/'..'/'..'/'..'/'CHANGELOG.md',
      version_path:   Pathname.new(__FILE__)/'..'/'..'/'..'/'version.rb',
    }
  end

  before do
    Pathname.new(options[:version_path]).write <<FILE
module FakeGem
  VERSION = "0.9.0"
end
FILE
  end

  after { File.delete(options[:version_path]) }

  it "sets the gem's version to the current changelog version" do
    task.execute(options)

    require options[:version_path]

    changelog_version = StructuredChangelog.new(options[:changelog_path]).version.to_s
    gem_version       = FakeGem::VERSION

    expect(gem_version).to eq changelog_version
  end
end
