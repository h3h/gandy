namespace :gandy do

  task :install do
    Gandy::Installer.install!(Dir.pwd)
  end

  task :maintain do
    puts "I could maintain now."
  end

end
