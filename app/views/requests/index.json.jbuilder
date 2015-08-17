json.array!(@requests) do |request|
  json.extract! request, :id, :name, :phone, :email, :nationalid, :patientname, :faselty, :expiredate, :bloodbag, :hospitalname, :hospitalphone, :hospitaladdress
  json.url request_url(request, format: :json)
end
