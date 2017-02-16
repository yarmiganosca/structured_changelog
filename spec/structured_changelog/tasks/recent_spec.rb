require 'fantaskspec'
require 'structured_changelog/tasks/recent'

RSpec.describe 'rake changelog:recent', type: :rake do
  let(:task_name) { 'changelog:recent' }

  let(:options) { {path: Pathname.new(__FILE__)/'..'/'..'/'..'/'CHANGELOG.md'} }

  it 'displays the n most recent release sections' do
    expect { task.execute(options) }.to output(/0\.10\.0.*0\.2\.0.*0\.1\.1/m).to_stdout
  end
end
