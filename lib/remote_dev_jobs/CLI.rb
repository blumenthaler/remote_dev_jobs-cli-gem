require 'launchy'

class RemoteDevJobs::CLI

  def run(site_class)
    make_jobs(site_class)
    add_attributes_to_jobs(site_class)
    display_jobs
    show_job_info
  end

  def make_jobs(site_class)
    jobs_array = site_class.scrape_job_list.compact
    Job.create_from_collection(jobs_array)
  end

  def add_attributes_to_jobs(site_class)
    Job.all.each do |job|
      attributes = site_class.scrape_job_page(job.job_url)
      job.add_job_attributes(attributes)
    end
  end

  def display_jobs
    Job.all.each do |job|
      puts "\e[32m#{job.number}."
      puts "\n\e[34m#{job.company}:" if job.company
      puts "  \e[91m#{job.position}"
      puts "  \e[92m#{job.location}"
      if job.company == nil
        puts "\n \e[37m#{job.description}"
      end
      puts "  \e[37mSeniority: #{job.seniority}" if job.seniority
      puts "\n\e[32m#{'#' * 20}\n"
    end
  end

  def show_job_info
    choice = 'X'
    puts "\n\n\e[33m#{Job.all.count} jobs found! Scroll up to view them all.\e[0m"
    puts "\nIf you would like to see more information about a job,"
    puts "here are your options:"
    puts "\n(Options 1 and 3 not available for FlexJobs)"
    puts "\n\e[32m1.\e[37m    To see a description of the company and position,"
    puts "     please type the number of the company:"
    puts ""
    puts "\e[32m2.\e[37m    To visit the job page, type the number of the"
    puts "     company, followed by 'job page':"
    puts ""
    puts "\e[32m3.\e[37m    To visit the company website, type the number of the"
    puts "     company, followed by 'site':"
    puts "(Type exit if you would like to exit to the main menu)"
    while choice != 'exit'
      choice = STDIN.gets.chomp
      already_opened = nil
      Job.all.each do |job|
        if job.number.to_s == choice && job.company
          10.times do puts "" end
          puts "\e[91mDescription:"
          puts "\n  \e[37m#{job.description}"
          if job.company_site
            puts "\n\e[91mCompany Website:"
            puts "\n \e[37m#{job.company_site}"
          end
          puts "\n(You may need to scroll up to see the menu again.)"
        elsif "#{job.number} job page" == choice 
          Launchy.open("#{job.job_url}")
        elsif "#{job.number} site" == choice && job.company && already_opened == nil
          if job.company_site != "Not listed." 
            Launchy.open("#{job.company_site}")
            already_opened = "yep"
          elsif job.company_site == nil
            puts "\n\nWe're sorry, we can't access the company's website."
          end
        end
      end
    end    
  end

end

