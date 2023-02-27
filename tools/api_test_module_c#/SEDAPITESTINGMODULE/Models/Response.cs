using Newtonsoft.Json;

namespace Models
{
    public abstract class Response
    {
        public int status { get; set; }
        public string? message { get; set; }
    }

    public class LoginRequest : Response
    {
        public string? token { get; set; }
    }

    public class ForgotRequest : Response
    {
        public string? support { get; set; }
    }

    public class HomeRequest : Response
    {
        [JsonProperty("Images")]
        public List<string?> Images { get; set; } = new List<string?>();
    }
}
