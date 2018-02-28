# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(first_name: "Maria", last_name: "Escobar", dob: "09/10/1980", street_address: "1234 Lakeshore Drive", city: "Chicago", state: "Illinois", zip: 60611, phone_number: "312-555-1234", email: "maria@email.com", password: "password", password_confirmation: "password")

# User.create(first_name: "Dan", last_name: "Chu", dob: "12/3/1990", street_address: "2345 Lakeshore Drive", city: "Chicago", state: "Illinois", zip: 60611, phone_number: "312-555-1234", email: "dan@email.com", password: "password", password_confirmation: "password")

# Medication.create(name: "Gleevec (imatinib)")
# Medication.create(name: "Xeloda (capecitabine)")

# Provider.create(name: "Alan Kim, MD", address: "555 Michigan Avenue, Chicago, Illinois 60611")
# Provider.create(name: "Mahsa Mohebtash, MD", address: "1234 Union Drive, Baltimore, Maryland 21043")

# Diagnosis.create(name: "Multiple myeloma not having achieved remission", icd_10_code: "C90.00")
# Diagnosis.create(name: "Malignant neoplasm of colon, unspecified", icd_10_code: "C18.9")

# UserMedication.create(diagnosis_id: 1, medication_id: 1, user_id: 1, dosage: "400 mg PO qDay", doctor_id: 1)
# UserMedication.create(diagnosis_id: 2, medication_id: 2, user_id: 2, dosage: "1250 mg PO b.i.d.", doctor_id: 2)

# UserProvider.create(user_id: 1, provider_id: 1)
# UserProvider.create(user_id: 2, provider_id: 2)

Timer.create(last_rang: time.now, increment: , timerable_id: 1 , timerable_type: Provider)
Timer.create(last_rang: time.now, increment: , timerable_id: 2, timerable_type: Medication)