module RunsHelper
  include TavernaPlayer::RunsHelper

  def run_state_icon(run)
    icon = case run.state
      when :pending
        'glyphicon-time'
      when :running
        'glyphicon-ok-circle'
      when :failed
        'glyphicon-remove-circle'
      when :cancelled
        'glyphicon-ban-circle'
      when :finished
        'glyphicon-ok-circle'
    end

    content_tag('span', nil, :class => "glyphicon #{icon}", :title => run.saved_state.to_s.humanize)
  end
end