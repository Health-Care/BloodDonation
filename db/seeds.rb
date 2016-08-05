# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(id: 1,name: 'donor 1', email: 'ibrahim1@gmail.com',password: '12345678', phone: "01220062113", nationalid: "12312312312321", blood_type: "A+", gender: "male", lastdonation: "2015-09-22", savedpeople: 1, location_lat: 30.101105, location_lng: 31.21968400000003, location_name: "Warraq Al Hadar, Warraq Al Arab, Al Warraq, Giza G...", num_of_active_requests: 2, pause: false, birth_date: "2015-09-01", notifications: 0, can_donate: true, hide_account: false, stop_getting_email: false)
User.create(id: 2,name: 'donor 2', email: 'ibrahim2@gmail.com',password: '12345678', phone: "01220062000", nationalid: "12312312312311", blood_type: "A+", gender: "male", lastdonation: nil, savedpeople: 0, location_lat: 30.101105, location_lng: 31.21968400000003, location_name: "Warraq Al Hadar, Warraq Al Arab, Al Warraq, Giza G...", num_of_active_requests: 1, pause: false, birth_date: "2015-09-01", notifications: 0, can_donate: true, hide_account: false, stop_getting_email: false)
User.create(id: 3,name: 'donor 3', email: 'ibrahim3@gmail.com',password: '12345678', phone: "01220062123", nationalid: "12312312312300", blood_type: "O-", gender: "male", lastdonation: nil, savedpeople: 0, location_lat: 30.101105, location_lng: 31.21968400000003, location_name: "Warraq Al Hadar, Warraq Al Arab, Al Warraq, Giza G...", num_of_active_requests: 0, pause: false, birth_date: "2015-09-01", notifications: 0, can_donate: true, hide_account: false, stop_getting_email: false)



Request.create(id: 1,contact_name: "contact 1", contact_phone: "01227462847", contact_email: "ibrahim@faselty.me", contact_nationalid: "12312312312311", patient_name: "patient 1", blood_type: "A+", expiredate: "2015-11-2", bloodbag: 2, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 2 )
Request.create(id: 2,contact_name: "contact 2", contact_phone: "01227462111", contact_email: "ibrahim1@faselty.me", contact_nationalid: "12312312312312", patient_name: "patient 2", blood_type: "A-", expiredate: "2015-11-3", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 3,contact_name: "contact 3", contact_phone: "01227462222", contact_email: "ibrahim2@faselty.me", contact_nationalid: "12312312312313", patient_name: "patient 3", blood_type: "A+", expiredate: "2015-11-4", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 1 )
Request.create(id: 4,contact_name: "contact 4", contact_phone: "01227462333", contact_email: "ibrahim3@faselty.me", contact_nationalid: "12312312312314", patient_name: "patient 4", blood_type: "O+", expiredate: "2015-11-5", bloodbag: 5, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 5,contact_name: "contact 5", contact_phone: "01227462444", contact_email: "ibrahim4@faselty.me", contact_nationalid: "12312312312315", patient_name: "patient 5", blood_type: "B+", expiredate: "2015-11-6", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 6,contact_name: "contact 6", contact_phone: "01227462555", contact_email: "ibrahim5@faselty.me", contact_nationalid: "12312312312316", patient_name: "patient 6", blood_type: "B-", expiredate: "2015-11-7", bloodbag: 1, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 7,contact_name: "contact 7", contact_phone: "01227462666", contact_email: "ibrahim6@faselty.me", contact_nationalid: "12312312312317", patient_name: "patient 7", blood_type: "AB+", expiredate: "2015-11-8", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 8,contact_name: "contact 8", contact_phone: "01227462777", contact_email: "ibrahim7@faselty.me", contact_nationalid: "12312312312318", patient_name: "patient 8", blood_type: "AB-", expiredate: "2015-11-9", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 9,contact_name: "contact 9", contact_phone: "01227462888", contact_email: "ibrahim8@faselty.me", contact_nationalid: "12312312312319", patient_name: "patient 9", blood_type: "A+", expiredate: "2015-11-10", bloodbag: 4, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 10,contact_name: "contact 10", contact_phone: "01227469991", contact_email: "ibrahim9@faselty.me", contact_nationalid: "12312312312310", patient_name: "patient 10", blood_type: "A-", expiredate: "2015-11-21", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 11,contact_name: "contact 11", contact_phone: "01227461232", contact_email: "ibrahim10@faselty.me", contact_nationalid: "12312312312321", patient_name: "patient 11", blood_type: "O-", expiredate: "2015-11-22", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 12,contact_name: "contact 12", contact_phone: "01227462213", contact_email: "ibrahim11@faselty.me", contact_nationalid: "12312312312331", patient_name: "patient 12", blood_type: "O-", expiredate: "2015-11-11", bloodbag: 2, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 13,contact_name: "contact 13", contact_phone: "01227462844", contact_email: "ibrahim12@faselty.me", contact_nationalid: "12312312312341", patient_name: "patient 13", blood_type: "B+", expiredate: "2015-11-12", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 14,contact_name: "contact 14", contact_phone: "01227462847", contact_email: "ibrahim13@faselty.me", contact_nationalid: "12312312312351", patient_name: "patient 14", blood_type: "A+", expiredate: "2015-11-12", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 15,contact_name: "contact 15", contact_phone: "01227462847", contact_email: "ibrahim14@faselty.me", contact_nationalid: "12312312312361", patient_name: "patient 15", blood_type: "A+", expiredate: "2015-11-22", bloodbag: 9, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 16,contact_name: "contact 16", contact_phone: "01227462847", contact_email: "ibrahim15@faselty.me", contact_nationalid: "12312312312371", patient_name: "patient 16", blood_type: "A+", expiredate: "2015-11-1", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 17,contact_name: "contact 17", contact_phone: "01227462847", contact_email: "ibrahim16@faselty.me", contact_nationalid: "12312312312381", patient_name: "patient 17", blood_type: "AB+", expiredate: "2015-11-2", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 18,contact_name: "contact 18", contact_phone: "01227462847", contact_email: "ibrahim17@faselty.me", contact_nationalid: "12312312312391", patient_name: "patient 18", blood_type: "A+", expiredate: "2015-11-3", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 19,contact_name: "contact 19", contact_phone: "01227462847", contact_email: "ibrahim18@faselty.me", contact_nationalid: "12312312312301", patient_name: "patient 19", blood_type: "O+", expiredate: "2015-11-4", bloodbag: 6, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )
Request.create(id: 20,contact_name: "contact 20", contact_phone: "01227462847", contact_email: "ibrahim19@faselty.me", contact_nationalid: "12312312312221", patient_name: "patient 20", blood_type: "O+", expiredate: "2015-11-5", bloodbag: 3, hospital_name: "wardan imbaba", hospital_location: "Wardan Al Roum, Cairo Governorate, Egypt", created_at: "2015-09-04", updated_at: nil, hospital_location_lat: 31.236065800000006, hospital_location_lng: 30.0166197, num_of_donors: 0 )

ActiveRequest.create(id: 1,donor_id: "1", request_id: "1")
ActiveRequest.create(id: 2,donor_id: "2", request_id: "1")
ActiveRequest.create(id: 3,donor_id: "1", request_id: "3")