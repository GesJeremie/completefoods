class SlackPublisher
  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context

  def vote_created(vote)
    return unless can_notify?

    fields = [
      { title: 'Product', value: vote.product.name, short: true },
      { title: 'Recommend?', value: vote.recommend? ? 'Yes' : 'No', short: true },
      { title: 'Reason', value: vote.reason, short: false }
    ]

    actions = [
      { type: 'button', text: 'Show Vote', url:  admin_product_vote_url(vote.id) }
    ]

    publish('Vote Added', fields, actions, action_required: true)
  end

  private

  def can_notify?
   Rails.env.production?
  end

  def notifier
    @notifier ||= Slack::Notifier.new(webhook_url)
  end

  def webhook_url
    CompleteFoods.config.slack[:webhook_url]
  end

  def publish(title, fields = [], actions = [], action_required: false)
    notifier.post(
      channel: '#completefoods',
      icon_emoji: ':bender:',
      username: 'Bender',
      attachments: [
        {
          title: title,
          color: action_required ? 'warning' : '#a4b0be',
          fields: fields,
          actions: actions
        }
      ]
    )
  end
end
