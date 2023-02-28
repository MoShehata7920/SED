
using SEDAPITESTINGMODULE.Discord;

public static class Extensions
{
    public static async Task WriteLineAsync(string message, ConsoleColor color)
    {
        Console.ForegroundColor = color;
        Console.WriteLine($"[{DateTime.Now}]: {message}");
        Console.WriteLine("======================================================================================");

        List<string> lines = new List<string>();

        lines = message
            .Chunk(1000)
            .Select(x => new string(x))
            .ToList();

        foreach (var x in lines)
        {
            await DiscordManger.sendEmbed("API_LOGS", "SED", x);
        }
    }

}
