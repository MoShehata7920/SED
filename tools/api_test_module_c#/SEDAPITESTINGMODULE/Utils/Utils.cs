public static class Utils
{
    public static string generateToken()
    {
        var allChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        var random = new Random();
        var resultToken = new string(
           Enumerable.Repeat(allChar, 8)
           .Select(token => token[random.Next(token.Length)]).ToArray());

        return resultToken.ToString();
    }
}