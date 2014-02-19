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

  private

  def parse_workflow_document
    t2flow = T2Flow::Parser.new.parse(document.queued_for_write[:original].read)

    self.title = t2flow.annotations.titles.last
    self.description = t2flow.annotations.descriptions.last

    self.input_ports = []
    self.output_ports = []

    t2flow.sources.each do |input|
      self.input_ports.build(:name => input.name,
                        :description => (input.descriptions || []).last,
                        :example_value => (input.example_values || []).last)
    end

    t2flow.sinks.each do |output|
      self.output_ports.build(:name => output.name,
                        :description => (output.descriptions || []).last,
                        :example_value => (output.example_values || []).last)
    end
  end

end
