class CollectionsViewModel < ApplicationViewModel
  def collections
    @collections ||=
      begin
        Rails.configuration.collections.group_by { |collection| collection[:group] }
      end
  end
end
