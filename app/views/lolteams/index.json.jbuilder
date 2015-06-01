json.array!(@lolteams) do |lolteam|
  json.extract! lolteam, :id, :user_id, :bet_id, :slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7
  json.url lolteam_url(lolteam, format: :json)
end
