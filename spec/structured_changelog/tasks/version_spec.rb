require 'fantaskspec'
require 'structured_changelog/tasks/version'

RSpec.describe 'rake changelog:version', type: :rake do
  let(:task_name) { 'changelog:version' }
  let(:options)   { {path: Pathname.new(__FILE__)/'..'/'..'/'..'/'CHANGELOG.md'} }

  it 'prints the current version according to the changelog' do
    expect { task.execute(options) }.to output(/^0\.10\.0$/).to_stdout
  end
end
