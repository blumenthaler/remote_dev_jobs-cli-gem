require 'pry'
class RemoteDevJobs::Launch
  
  def self.logo
    puts "$%$%$%  $%$%$%  $%      %$    $%   $%$%$%  $%$%$%"
    puts "%    %  %        $%    %$    %   %   $%    $     "
    puts "$$%$%$  $%$%$%    %$  $%    $    $   %$    %$%$%$"
    puts "%    %  %       %  $%    $  %    %   $%    $     "
    puts "$    $  $       %        %   $  $    %$    %     "
    puts "%    %  %$%$%$  $        $    %$     $%    $$%$%$"
    puts ""
    puts "       $%$%$%   $%    $%$%$%  $%$%$%             "
    puts "         $%    %  %   $%   $  %                  "
    puts "         $%   $    $  $$%$%$  $%$%$%             "
    puts "         %$   %    %  $%   %       $             "
    puts "         $%   %   $   $%   $       %             "
    puts "      $%%$%     %$    %$%$%$  %$%$%$             "               
  end

  def self.search_options
    3.times do puts '' end
    self.logo
    2.times do puts "" end
    puts "Hello and welcome to Remote Jobs! We help you to find remote web"
    puts "development positions, with seniority level when possible."
    puts ""
    puts "To begin, please select the jobs site you would like to search"
    puts "by selecting the number of the site in the following list:"
    puts "(If you would like to exit, please type exit.)"
    puts ""
    puts "1. Stack Overflow Careers (Seniority level shown)"
    puts "2. Authentic Jobs"
    puts "3. We Work Remotely (100% Remote Jobs)"
    puts "4. FlexJobs (Entry-level focus, company name requires login)"
    @input = gets.chomp
  end

  def self.wait_message
    puts "Searching the site... this will take a moment."
    puts "Thank you for your patience."
  end



def self.sitemenu
  while @input != 'exit'
    if @input == '1'
      wait_message
      RemoteDevJobs::CLI.new.run(StackScraper)
      search_options
    elsif @input == '2'
      wait_message
      RemoteDevJobs::CLI.new.run(AuthenticScraper)
      search_options
    elsif @input == '3'
      wait_message
      RemoteDevJobs::CLI.new.run(WeWorkRemotelyScraper)
      search_options
    elsif @input == '4'
      wait_message
      RemoteDevJobs::CLI.new.run(FlexJobsScraper)
      search_options
    elsif @input == 'exit'
      'do nothing'
    end
  end
end

self.search_options
self.sitemenu


end