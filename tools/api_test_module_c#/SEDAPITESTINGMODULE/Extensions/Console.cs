
using SEDAPITESTINGMODULE.Discord;

public static class Extensions
{
    public static async Task WriteLineAsync(string message, ConsoleColor color)
    {
        Console.ForegroundColor = color;
        Console.WriteLine($"[{DateTime.Now}]: {message}");
        Console.WriteLine("======================================================================================");

        await DiscordManger.sendEmbed("API_LOGS", "SED", message);
    }

}
