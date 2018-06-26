require 'tmpdir'

require 'structured_changelog/tasks/compile'

RSpec.describe 'rake changelog:compile', type: :rake do
  let(:task_name) { 'changelog:compile' }
  let(:options)   { {repo_path: repo_path, changelog_path: changelog_path} }
  
  let(:tmpdir)         { Pathname.new(Dir.mktmpdir) }
  let(:repo_path)      { tmpdir }
  let(:changelog_path) { tmpdir/'CHANGELOG.md' }

  let(:previous_section) { "## RELEASE 1.0.0\n\n* BREAKING: it's so much better now (right? please let it actually be better oh no it isn't is it)" }

  before do
    @repo = Git.init(repo_path.to_s)

    changelog_path.write(previous_section)

    @repo.add(all: true)
    @repo.commit("first commit")
    @repo.add_tag("v1.0.0")
  end

  after do
    tmpdir.rmtree
  end

  context "with changelog commits since the last release" do
    let(:fix_lines)   { "* FIX: we fixed something\n* FIX: we fixed something else" }
    let(:fix_message) { "[CHANGELOG]\n\n#{fix_lines}" }

    let(:feature_line)    { "* FEATURE: we added something" }
    let(:feature_message) { "[CHANGELOG]\n\n#{feature_line}" }

    before do
      @repo.commit(fix_message, allow_empty: true)
      @repo.commit(feature_message, allow_empty: true)

      task.execute(options)
    end

    it 'adds a release section with all the changelog notes' do
      expect(changelog_path.read).to start_with(["## RELEASE 1.1.0\n", feature_line, fix_lines].join("\n"))
      expect(changelog_path.read).to include(previous_section)
    end
  end

  context "with no changelog commits since the last release" do
    # we're testing an abort so we run the task in another process
    before { Process.waitpid Process.fork { task.execute(options) } }

    it 'leaves CHANGELOG.md unchanged' do
      expect(changelog_path.read).to eq previous_section
    end
  end
end
