namespace :policy_consumer do
  task start: :environment do
    PolicyConsumer.receive
  end
end
