class Tape < ActiveRecord::Base
	require 'csv'
	require 'roo'

	belongs_to :customer
	has_many :movements
	has_many :locations, :through => :consignments, :source => :to_location
	has_many :contents, :foreign_key => :tape_id
	has_many :consignments, :through => :contents

	acts_as_paranoid
	auditable
	#def location
	#	Consignment.where('tape_id = ?', id).order(date: :desc).first.to_location
	#end

	def location
		if self.consignments.count !=0
			if self.consignments.order(updated_at: :desc).first.in_transit == true
				Location.find_by_location('In Transit')
			else
				self.consignments.order(updated_at: :desc).first.to_location
			end
		else
			Location.find_by_location('Unassigned')
		end
	end

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    tape = find_by_reference(row["reference"]) || new
	    tape.attributes = row.to_hash
			logger.debug "#{tape.attributes}"
	    tape.save
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
			when ".csv" then Roo::Csv.new(file.path)
		  when ".xls" then Roo::Excel.new(file.path)
		  when ".xlsx" then Roo::Excelx.new(file.path)
		else raise "Unknown file type: #{file.original_filename}"
	  end
	end
end
