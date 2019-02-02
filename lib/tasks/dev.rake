namespace :dev do
  desc 'Clear tmp, database and re-run all migrations and db:seed'
  task rebuild: [ 'tmp:clear', 'log:clear', 'db:drop', 'db:create',
                  'db:migrate', 'db:seed', 'dev:copy_config_example_files' ]

  desc 'Copy config example files'
  task :copy_config_example_files do
    Dir.glob("config/*.yml.example").each do |f|
      FileUtils.cp(f, f.gsub(/\.example/,''))

      puts "Copy #{f} To #{f.gsub(/\.example/,'')}"
    end

    puts 'Done.'
  end
end
