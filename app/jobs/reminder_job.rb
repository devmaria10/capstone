class ReminderJob < ApplicationJob
  queue_as :default

  def perform(timer)
    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['twilio_phone_number'],
      to: '17739312525',
      body: "Time to take your medication!"
    })

    timer.update(last_rang: Time.now)
  end
end


