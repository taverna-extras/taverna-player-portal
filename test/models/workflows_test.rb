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

  test "filters out non-visible workflows" do
    visible = create_list(:workflow, 2)
    invisible = create_list(:private_workflow, 3)

    user = create(:user)

    results = Workflow.visible_by(user)

    assert_equal visible.size, results.size
    assert (visible - results).empty?
    assert (results & invisible).empty?
  end

end
