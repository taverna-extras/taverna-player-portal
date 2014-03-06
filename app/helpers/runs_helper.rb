module RunsHelper
  include TavernaPlayer::RunsHelper

  def run_state_icon(run)
    icon = nil
    colour = nil

    case run.state
      when :pending
        icon = 'glyphicon-time'
        colour = 'state-pending'
      when :running
        icon = 'glyphicon-ok-circle'
        colour = 'state-pending'
      when :failed
        icon = 'glyphicon-remove-circle'
        colour = 'state-failed'
      when :cancelled
        icon = 'glyphicon-ban-circle'
        colour = 'state-cancelled'
      when :finished
        icon = 'glyphicon-ok-circle'
        colour = 'state-finished'
    end

    content_tag('span', nil, :class => "glyphicon #{icon} #{colour}", :title => run.saved_state.to_s.humanize)
  end
end