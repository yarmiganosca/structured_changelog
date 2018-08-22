require 'tmpdir'

require 'structured_changelog/tasks/compile'

RSpec.describe 'rake changelog:preview', type: :rake do
  let(:task_name) { 'changelog:preview' }
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

  subject(:preview) { `rake changelog:preview\[#{repo_path},#{changelog_path}\]`.chomp }

  context "with changelog commits since the last release" do
    let(:fix_lines)   { "* FIX: we fixed something\n* FIX: we fixed something else" }
    let(:fix_message) { "here is a description\n\n#{fix_lines}" }

    let(:feature_line)    { "* FEATURE: we added something" }
    let(:feature_message) { "here is a description\n\nand a line\n#{feature_line}\nand another line" }

    before do
      @repo.commit(fix_message, allow_empty: true)
      @repo.commit(feature_message, allow_empty: true)
    end

    it 'displays a release section with all the changelog notes' do
      expect(preview).to eq ["## RELEASE 1.1.0\n", feature_line, fix_lines].join("\n")
    end
  end

  context "with no changelog commits since the last release" do
    it 'leaves CHANGELOG.md unchanged' do
      expect(preview).to be_empty
    end
  end
end
