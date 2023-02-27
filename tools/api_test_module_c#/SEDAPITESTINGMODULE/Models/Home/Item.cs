using Newtonsoft.Json;

namespace Models
{
    public class Item
    {
        [JsonProperty("Name")]
        public string? Name { get; set; }

        [JsonProperty("Image")]
        public string? Image { get; set; }

        [JsonProperty("Descr")]
        public string? Descr { get; set; }

        [JsonProperty("Price")]
        public int? Price { get; set; }
    }
}
