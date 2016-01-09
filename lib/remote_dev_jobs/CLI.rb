require 'launchy'

class RemoteDevJobs::CLI

  def run(site_class)
    make_jobs(site_class)
    add_attributes_to_jobs(site_class)
    display_jobs
    show_job_info
  end

  def make_jobs(site_class)
    jobs_array = site_class.scrape_job_list
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
      puts "\n#{job.company}:" if job.company
      puts "  #{job.position}"
      puts "  #{job.location}"
      if job.company == nil
        puts "\n #{job.description}"
      end
      puts "  Seniority: #{job.seniority}" if job.seniority
      puts "\n#{'#' * 20}\n"
    end
  end

  def show_job_info
    choice = 'X'
    puts "\n\n#{Job.all.count} jobs found! Scroll up to view them all."
    puts "\nIf you would like to see more information about a job,"
    puts "here are your options:"
    puts "\n(Options 1 and 3 not available for FlexJobs)"
    puts "\n1.   To see a description of the company and position,"
    puts "     please type the company name exactly as it appears:"
    puts ""
    puts "2.   To visit the job page, type the company name followed"
    puts "     by 'job page' (if searching FlexJobs, type the position"
    puts "     followed by 'job page'):"
    puts ""
    puts "3.   To visit the company website, type the company name"
    puts "     followed by 'site':"
    puts "(Type exit if you would like to exit to the main menu)"
    while choice != 'exit'
      choice = gets.chomp
      already_opened = nil
      Job.all.each do |job|
        if job.company == choice
          10.times do puts "" end
          puts "Description:"
          puts "\n  #{job.description}"
          if job.company_site
            puts "\nCompany Website:"
            puts "\n  #{job.company_site}"
          end
          puts "\n(You may need to scroll up to see the menu again.)"
        elsif "#{job.company} job page" == choice || ("#{job.position} job page" == choice && job.company == nil)
          Launchy.open("#{job.job_url}")
        elsif "#{job.company} site" == choice && already_opened == nil
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

