using Newtonsoft.Json;

namespace Models
{
    public class Section
    {
        [JsonProperty("ID")]
        int ID { get; set; }

        [JsonProperty("Name")]
        string? Name { get; set; }
    }
}
