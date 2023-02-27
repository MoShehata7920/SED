
public interface ISettings : IDisposable
{
    string Address { get; set; }
    int? Port { get; set; }
    string Username { get; set; }
    string Password { get; set; }
    string SedDb { get; set; }
    ISettings Init();
}