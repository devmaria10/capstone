class ReminderJob < ApplicationJob
  queue_as :default

  def perform(timer, user_phone)
    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['twilio_phone_number'],
      to: user_phone,
      body: "Time to take your medication!"
    })

    timer.update(last_rang: Time.now)
  end
end


