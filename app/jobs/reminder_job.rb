class ReminderJob < ApplicationJob
  queue_as :default

  def perform(timer, user_phone, text)
    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['twilio_phone_number'],
      to: user_phone,
      body: "Time to take #{text}!"
    })

    if timer.repeating
     ReminderJob.set(wait: eval("#{timer.time_increment}.#{timer.increment_unit}")).perform_later(timer, user_phone, text)
     end

    timer.update(last_rang: Time.now)
  end
end


