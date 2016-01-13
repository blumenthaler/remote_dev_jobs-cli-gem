
class RemoteDevJobs::CLI::Job
  attr_accessor :company, :location, :position, :description, :job_url, :seniority, :company_site, :number

  @@all = []

  def initialize(job_hash)
    job_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(jobs_array)
    jobs_array.each_with_index do |job, index|
      if job
        job_hash = {
          number: index + 1,
          company: job[:company],
          location: job[:location],
          position: job[:position],
          seniority: job[:seniority],
          job_url: job[:job_url]
        }
        self.new(job_hash)
      end
    end
  end

  def add_job_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
  end

  def self.all
    @@all
  end

end

