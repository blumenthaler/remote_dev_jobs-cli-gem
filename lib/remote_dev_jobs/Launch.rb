require 'pry'
class RemoteDevJobs::Launch
  
  def self.logo
    puts "\e[32m$%$%$%  $%$%$%  $%      %$    $%   $%$%$%  $%$%$%"
    puts "\e[32m%    %  %        $%    %$    %   %   $%    $     "
    puts "\e[32m$$%$%$  $%$%$%    %$  $%    $    $   %$    %$%$%$"
    puts "\e[32m%    %  %       %  $%    $  %    %   $%    $     "
    puts "\e[32m$    $  $       %        %   $  $    %$    %     "
    puts "\e[32m%    %  %$%$%$  $        $    %$     $%    $$%$%$"
    puts ""
    puts "\e[32m       $%$%$%   $%    $%$%$%  $%$%$%             "
    puts "\e[32m         $%    %  %   $%   $  %                  "
    puts "\e[32m         $%   $    $  $$%$%$  $%$%$%             "
    puts "\e[32m         %$   %    %  $%   %       $             "
    puts "\e[32m         $%   %   $   $%   $       %             "
    puts "\e[32m      $%%$%     %$    %$%$%$  %$%$%$             "               
  end

  def self.search_options
    3.times do puts '' end
    self.logo
    2.times do puts "" end
    puts "\e[0mHello and welcome to Remote Jobs! We help you to find remote web"
    puts "development positions, with seniority level when possible."
    puts ""
    puts "To begin, please select the jobs site you would like to search"
    puts "by selecting the number of the site in the following list:"
    puts "(If you would like to exit, please type exit.)"
    puts ""
    puts "\e[32m1.\e[37m Stack Overflow Careers (Seniority level shown)"
    puts "\e[32m2.\e[37m Authentic Jobs"
    puts "\e[32m3.\e[37m We Work Remotely (100% Remote Jobs)"
    puts "\e[32m4.\e[37m FlexJobs (Entry-level focus, company name requires login)"
  end

  def self.wait_message
    puts "Searching the site... this will take a moment."
    puts "Thank you for your patience."
  end



def self.sitemenu
  input = 'X'
  while input != 'exit'
    input = STDIN.gets.chomp
    if input == '1'
      wait_message
      RemoteDevJobs::CLI.new.run(StackScraper)
      search_options
    elsif input == '2'
      wait_message
      RemoteDevJobs::CLI.new.run(AuthenticScraper)
      search_options
    elsif input == '3'
      wait_message
      RemoteDevJobs::CLI.new.run(WeWorkRemotelyScraper)
      search_options
    elsif input == '4'
      wait_message
      RemoteDevJobs::CLI.new.run(FlexJobsScraper)
      search_options
    elsif input == 'exit'
      'do nothing'
    end
  end
end



end