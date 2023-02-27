using Newtonsoft.Json;

namespace Models
{
    public abstract class Response
    {
        public int status { get; set; }
        public string? message { get; set; }
    }

    public class LoginResponse : Response
    {
        public string? token { get; set; }
    }

    public class ForgotResponse : Response
    {
        public string? support { get; set; }
    }

    public class HomeResponse : Response
    {
        [JsonProperty("Carousel")]
        public Carousel carousel { get; set; } = new Carousel();

        [JsonProperty("Categories")]
        public List<Categories> categories { get; set; } = new List<Categories>();

        [JsonProperty("Sell")]
        public List<Item> sellItems { get; set; } = new List<Item>();

        [JsonProperty("Donate")]
        public List<Item> donateItems { get; set; } = new List<Item>();

        [JsonProperty("Exchange")]
        public List<Item> exchangeItems { get; set; } = new List<Item>();
    }
}
