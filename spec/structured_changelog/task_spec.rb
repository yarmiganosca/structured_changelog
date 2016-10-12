require 'fantaskspec'
require 'structured_changelog/task'

RSpec.describe 'structured_changelog:validate', type: :rake do
  let(:task_name) { 'structured_changelog:validate' }

  it 'validates a good changelog' do
    options = {path: Pathname.new(__FILE__)/'..'/'..'/'CHANGELOG.md'}    

    expect { task.execute(options) }.to_not output.to_stdout
  end

  it "doesn't validate a bad changelog" do
    options = {path: Pathname.new(__FILE__)/'..'/'..'/'BADLOG.md'}

    expect { task.execute(options) }.to output(/No RELEASE blocks/).to_stdout
  end
end

RSpec.describe ''
