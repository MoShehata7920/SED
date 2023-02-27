namespace Setting
{
    public class Settings : ISettings
    {
        public string Address { get; set; }
        public int? Port { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string SedDb { get; set; }

        public ISettings Init()
        {
            Address = "0.0.0.0";
            Port = 1433;
            Username = "sa";
            Password = "123456";
            SedDb = "SED";

            return this;
        }

        public void Dispose()
        {
            Address = null;
            Port = null;
            Username = null;
            Password = null;
            SedDb = null;
        }
    }
}
