require 't2flow/model'
require 't2flow/parser'
require 't2flow/dot'

class Workflow < ActiveRecord::Base

  include Authorization

  belongs_to :user
  has_many :input_ports, class_name: 'WorkflowInputPort',
           dependent: :destroy
  has_many :output_ports, class_name: 'WorkflowOutputPort',
           dependent: :destroy
  has_many :runs, class_name: 'TavernaPlayer::Run', dependent: :destroy

  has_attached_file :document
  has_attached_file :diagram, styles: { thumb: ['100x100#', :jpg],
                                           large: ['400x400>', :jpg]
  }, default_url: '/images/:style/missing.png'

  validates :title, presence: true
  validates :user, presence: true
  validates :document, attachment_presence: true

  do_not_validate_attachment_file_type :diagram
  do_not_validate_attachment_file_type :document # Paperclip fails to validate t2flows which are uploaded as 'application/octet-stream'

  before_validation :parse_workflow_document

  def self.mime_type
    'application/vnd.taverna.t2flow+xml'
  end

  def file_path
    self.document.path
  end

  private

  def parse_workflow_document
    if document.dirty?
      t2flow = T2Flow::Parser.new.parse(document.queued_for_write[:original].read)
      diagram = Tempfile.new("image_#{t2flow.hash}")
      T2Flow::Dot.new.write_dot(diagram, t2flow)
      self.diagram = diagram
      diagram.close

      self.title = t2flow.annotations.titles.last || 'Untitled workflow'
      self.description = t2flow.annotations.descriptions.last

      self.input_ports = []
      self.output_ports = []

      t2flow.sources.each do |input|
        self.input_ports.build(name: input.name,
                          description: (input.descriptions || []).last,
                          example_value: (input.example_values || []).last)
      end

      t2flow.sinks.each do |output|
        self.output_ports.build(name: output.name,
                          description: (output.descriptions || []).last,
                          example_value: (output.example_values || []).last)
      end
    end
  end

end
