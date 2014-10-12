# bin/rake reviews:delete_orphaned
namespace :reviews do
  desc "Remove Reviews that are orphaned"
  task :delete_orphaned => :environment do
    Review.all.each do |review|

    end
  end
end
