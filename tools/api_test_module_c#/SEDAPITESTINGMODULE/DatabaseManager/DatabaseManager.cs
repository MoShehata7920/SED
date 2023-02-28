using Microsoft.EntityFrameworkCore;
using Setting;

namespace Database
{
    public class DatabaseManager : IDatabaseManager
    {
        public static SettingsManager? settingsManager;
        internal static string? SEDConnectionString = "";

        public DatabaseManager(SettingsManager settings)
        {
            settingsManager = settings;

            SEDConnectionString =
                $"data source={settings.Settings.Address},{settings.Settings.Port};initial catalog={settings.Settings.SedDb};persist security info =True; User Id={settings.Settings.Username};Password={settings.Settings.Password};MultipleActiveResultSets=True;App=DuckSoupEntityFramework;Encrypt=False;";

            try
            {
                using var context = new Context.SED();
                context.Database.Migrate();
                Extensions.WriteLineAsync("Successfully connected to the database :)", ConsoleColor.Green);

            }
            catch (Exception ex)
            {
                Extensions.WriteLineAsync(ex + " An error occurred while migrating the database", ConsoleColor.Red);
            }
        }

        public bool CheckConnection()
        {
            using (var db = new Context.SED())
            {
                return db.Database.CanConnect();
            }
        }

        public void Dispose()
        {

        }
    }
}
