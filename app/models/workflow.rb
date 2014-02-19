require 't2flow/model'
require 't2flow/parser'
require 't2flow/dot'

class Workflow < ActiveRecord::Base

  belongs_to :user
  has_many :input_ports, :class_name => 'WorkflowInputPort',
           :dependent => :destroy
  has_many :output_ports, :class_name => 'WorkflowOutputPort',
           :dependent => :destroy
  has_attached_file :document

  validates :title, :presence => true
  validates :document, :attachment_presence => true

  before_validation :parse_workflow_document

  def self.mime_type
    "application/vnd.taverna.t2flow+xml"
  end

  def t2flow
    @t2flow ||= T2Flow::Parser.new.parse(File.read(document.path))
  end

  private

  def parse_workflow_document
    title = t2flow.annotations.titles.last
    description = t2flow.annotations.descriptions.last

    input_ports.destroy_all
    output_ports.destroy_all

    t2flow.sources.each do |input|
      input_ports.build(:name => input.name,
                        :description => (input.descriptions || []).last,
                        :example_value => (input.example_values || []).last)
    end

    t2flow.sinks.each do |output|
      output_ports.build(:name => output.name,
                        :description => (output.descriptions || []).last,
                        :example_value => (output.example_values || []).last)
    end
  end

end
