
public static class Extensions
{
    public static void WriteLine(string message, ConsoleColor color)
    {
        Console.ForegroundColor = color;
        Console.WriteLine($"[{DateTime.Now}]: {message}");
        Console.WriteLine("======================================================================================");
    }

}
