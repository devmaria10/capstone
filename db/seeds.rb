# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(first_name: "Maria", last_name: "Escobar", dob: "09/10/1980", street_address: "1234 Lakeshore Drive", city: "Chicago", state: "Illinois", zip: 60611, phone_number: "312-555-1234", email: "maria@email.com")

Medication.create(name: "Gleevec(imatinib)")

Provider.create(name: "Alan Kim, MD", address: "555 Michigan Avenue, Chicago, Illinois 60611")
