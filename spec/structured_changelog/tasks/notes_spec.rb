require 'fantaskspec'
require 'structured_changelog/tasks/notes'

RSpec.describe 'rake changelog:notes', type: :rake do
  let(:task_name) { 'changelog:notes' }

  let(:options) { {path: path, query: query} }
  let(:path)    { Pathname.new(__FILE__)/'..'/'..'/'..'/'CHANGELOG.md' }

  let(:zero_one_zero) { "## RELEASE 0.1.0\n\n* FEATURE: thingy\n" }
  let(:zero_one_one)  { "## RELEASE 0.1.1\n\n* FIX: red\n" }
  let(:zero_two_zero) { "## RELEASE 0.2.0\n\n* FEATURE: blue\n" }

  let(:printout) { releases.join("\n") }

  context "by default" do
    let(:options) { {path: path} }
    let(:releases) { [zero_two_zero] }

    it 'displays notes for the current version' do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end
  
  context "current release" do
    let(:query) { "current" }
    let(:releases) { [zero_two_zero] }

    it 'displays notes for the current version' do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end

  context "every release" do
    let(:query) { "all" }
    let(:releases) { [zero_two_zero, zero_one_one, zero_one_zero] }

    it "displays the notes for all the releases" do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end

  context "single release" do
    let(:query) { "0.1.0" }
    let(:releases) { [zero_one_zero] }

    it 'displays notes for just that release' do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end

  context "releases after a version" do
    let(:query) { "0.1.1<" }
    let(:releases) { [zero_two_zero, zero_one_one] }

    it 'displays the notes for 0.1.0, 0.1.1, 0.2.0' do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end

  context "releases before a version" do
    let(:query) { "<0.1.1" }
    let(:releases) { [zero_one_one, zero_one_zero] }

    it 'displays the notes for 0.1.0, 0.1.1, 0.2.0' do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end

  context "releases between two versions" do
    let(:query) { "0.1.0<0.2.0" }
    let(:releases) { [zero_two_zero, zero_one_one, zero_one_zero] }

    it 'displays the notes for 0.1.0, 0.1.1, 0.2.0' do
      expect { task.execute(options) }.to output(printout).to_stdout
    end
  end
end
