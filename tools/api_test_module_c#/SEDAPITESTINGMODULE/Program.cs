using Database;
using Library.Webserver;
using SEDAPITESTINGMODULE.Discord;
using Setting;
public static class Program
{
    private static void Main()
    {
        Task.Run(async () => DiscordManger.MainAsync());

        Console.Title = "SED | A tool to test api";

        var webserverManager = new WebserverManager();

        var settingsManager = new SettingsManager();

        var databaseManager = new DatabaseManager(settingsManager);


        if (!databaseManager.CheckConnection())
            return;

        Console.ReadLine();
    }


}