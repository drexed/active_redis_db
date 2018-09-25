# frozen_string_literal: true

class ActiveOrm::Railtie < Rails::Railtie

  rake_tasks do
    Dir[File.expand_path('tasks/*.rake', File.dirname(__FILE__))].each { |ext| load(ext) }
  end

end
