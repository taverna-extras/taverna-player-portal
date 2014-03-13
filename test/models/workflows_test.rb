require 'test_helper'

class WorkflowsTest < ActiveSupport::TestCase

  test "can create workflow" do
    workflow = build(:workflow)

    assert workflow.save
  end

  test "workflow is parsed correctly" do
    workflow = create(:workflow)

    assert_equal 'Various output types', workflow.title
    assert_equal 'This workflow has various outputs types - a list, an XML text, a JSON text and an image.',
                 workflow.description
    assert_equal 1, workflow.input_ports.size
    assert_equal 4, workflow.output_ports.size
  end

end
