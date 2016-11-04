require 'fantaskspec'
require 'structured_changelog/tasks/notes'

RSpec.describe 'rake changelog:notes', type: :rake do
  let(:task_name) { 'changelog:notes' }

  let(:options) { {path: path, query: query} }
  let(:path)    { Pathname.new(__FILE__)/'..'/'..'/'..'/'CHANGELOG.md' }

  let(:changelog) { StructuredChangelog.new(path) }
  let(:releases)  { changelog.find_releases(query) }
  let(:contents)  { releases.map(&:contents).join }

  context "single release" do
    let(:query) { "0.1.0" }

    it 'displays notes for just that release' do
      expect { task.execute(options) }.to output(contents).to_stdout
    end
  end

  context "every release" do
    let(:query) { "ALL" }

    it "displays the notes for all the releases" do
      expect { task.execute(options) }.to output(contents).to_stdout
    end
  end

  context "releases after a version" do
    let(:query) { "0.1.0<" }

    it 'displays the notes for 0.1.0, 0.1.1, 0.2.0' do
      expect { task.execute(options) }.to output(contents).to_stdout
    end
  end

  context "releases before a version" do
    let(:query) { "<0.2.0" }

    it 'displays the notes for 0.1.0, 0.1.1, 0.2.0' do
      expect { task.execute(options) }.to output(contents).to_stdout
    end
  end

  context "releases between two versions" do
    let(:query) { "0.1.0<0.2.0" }

    it 'displays the notes for 0.1.0, 0.1.1, 0.2.0' do
      expect { task.execute(options) }.to output(contents).to_stdout
    end
  end
end
