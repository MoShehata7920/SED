using Newtonsoft.Json;

namespace Models
{
    public class Categories
    {
        [JsonProperty("ID")]
        public int ID { get; set; }

        [JsonProperty("Name")]
        public string? Name { get; set; }

        [JsonProperty("Image")]
        public string? Image { get; set; }
    }
}
