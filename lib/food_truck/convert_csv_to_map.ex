defmodule FoodTruck.ConvertCsvToMap do
  def execute(path) do
    path
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.to_list()
    |> Enum.map(&convert_map_to_fields/1)
  end

  defp convert_map_to_fields({_, map}) do
    %{
      address: map["Address"],
      applicant: map["Applicant"],
      approved: map["Approved"],
      expiration_date: map["ExpirationDate"],
      facility_type: map["FacilityType"],
      fire_prevention_districts: map["Fire Prevention Districts"],
      food_items: map["FoodItems"],
      latitude: map["Latitude"] |> convert_to_float(),
      location: map["Location"],
      location_description: map["LocationDescription"],
      longitude: map["Longitude"] |> convert_to_float(),
      noi_sent: map["NOISent"],
      neighborhoods: map["Neighborhoods (old)"],
      police_districts: map["Police Districts"],
      prior_permit: map["PriorPermit"],
      received: map["Received"],
      schedule: map["Schedule"],
      status: map["Status"],
      supervisor_districts: map["Supervisor Districts"],
      x: map["X"],
      y: map["Y"],
      zip_codes: map["Zip Codes"],
      block: map["block"],
      blocklot: map["blocklot"],
      cnn: map["cnn"],
      dayshours: map["dayshours"],
      locationid: map["locationid"],
      permit: map["permit"]
    }
  end

  defp convert_to_float("0"), do: 0.0
  defp convert_to_float(field), do: field |> String.to_float()
end
