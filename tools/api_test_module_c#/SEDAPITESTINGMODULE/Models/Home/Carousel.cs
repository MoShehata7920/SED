using Newtonsoft.Json;

namespace Models
{
    public class Carousel
    {
        [JsonProperty("Images")]
        public List<string?> Images { get; set; } = new List<string?>();
    }
}
