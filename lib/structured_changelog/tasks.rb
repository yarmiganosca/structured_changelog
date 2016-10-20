Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rb')].each(&method(:require))
