json.success @newsletter.save
json.errors @newsletter.errors.full_messages.to_sentence
