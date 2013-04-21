#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Puck::Application.load_tasks


namespace :db do
  namespace :schema do  

    # Default schema dumper for sqlite includes sqlite_autoindex_*** indicies, which
    # cause errors when the schema is loaded into a new (ex: test) database
    # Workaround is to remove the index creation commands for these indicies.
    task :dump do
      schema_path = File.expand_path('../db/schema.rb', __FILE__)
      File.open("#{schema_path}.bak", "w") do |ofile|
        File.foreach(schema_path) do |iline|
          ofile.puts(iline) unless iline =~ /sqlite_autoindex/
        end
      end
      FileUtils.move("#{schema_path}.bak", schema_path)
    end
  end
end
