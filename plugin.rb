# frozen_string_literal: true

# name: pm-convert
# about: enable programming TAs to convert PMs into topics
# version: 0.1
# authors: Alan Liang
# url: https://github.com/acm-21/discourse-pm-convert.git

PLUGIN_NAME ||= 'PmConvert'

after_initialize do
  class ::Guardian
    module OverridingGuardian
      def can_convert_topic?(topic)
        return true if super(topic)
        return false if is_anonymous?
        return true if @user.groups.any? {|group| group.name == 'Programming-TAs' }
        false
      end
    end
    prepend OverridingGuardian
  end
end
