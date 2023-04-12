class BoredService
  def fetch_api
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "http://www.boredapi.com/api/activity?type=charity")
  end
end
