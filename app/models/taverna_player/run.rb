#------------------------------------------------------------------------------
# Copyright (c) 2013 The University of Manchester, UK.
#
# BSD Licenced. See LICENCE.rdoc for details.
#
# Taverna Player was developed in the BioVeL project, funded by the European
# Commission 7th Framework Programme (FP7), through grant agreement
# number 283359.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

module TavernaPlayer
  class Run < ActiveRecord::Base
    # Do not remove the next line.
    include TavernaPlayer::Concerns::Models::Run

    # Extend the Run model here.

    include Authorization

    belongs_to :user

    alias_method :original_default_policy, :default_policy
    def default_policy
      if user.nil?
        Policy.new(:title => 'Default Guest Private Policy', :public_permissions => [])
      else
        original_default_policy
      end
    end

  end
end
