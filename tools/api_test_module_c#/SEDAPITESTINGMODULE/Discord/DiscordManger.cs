using Discord;
using Discord.WebSocket;

namespace SEDAPITESTINGMODULE.Discord
{
    public static class DiscordManger
    {
        private static DiscordSocketClient? _client;
        public static bool connected = false;
        public async static Task MainAsync()
        {
            _client = new DiscordSocketClient(new DiscordSocketConfig() { LogLevel = LogSeverity.Info, GatewayIntents = GatewayIntents.All });

            var token = "MTA3OTkxODY2NjI4OTc5MTEwNw.G8hPmo.otaIjVlI87v6kSn9myDS9expVLMssCDKrEUhh8";

            _client.MessageReceived += MessageReceived;

            await _client.LoginAsync(TokenType.Bot, token);

            await _client.StartAsync();

            await Task.Delay(-1);

        }

        public static ulong GetChannelIdByName(string ChannelName)
        {

            ulong ChannelID = 0;
            foreach (var server in _client!.Guilds)
                foreach (var c in server.Channels)
                    if (c.Name == ChannelName)
                        ChannelID = c.Id;
            return ChannelID;
        }

        public async static Task sendEmbed(string Title = "", string Footer = "", string Desc = "", string ImageUrl = "", string Thumbnail = "", int type = 0)
        {
            try
            {
                if (_client == null) return;

                ConnectionState connectionState = _client.ConnectionState;

                if (connectionState == ConnectionState.Connected)
                {
                    var chnl = _client!.GetChannel(GetChannelIdByName("api-logs")) as IMessageChannel;
                    await chnl!.SendMessageAsync($"```json\n{Desc}```");
                }
            }
            catch { }
        }

        public static async Task SendEmbed(ulong ChannelID, string Title = "", string Footer = "", string Desc = "", string ImageUrl = "", string Thumbnail = "", int type = 0)
        {
            try
            {
                if (ChannelID != 0)
                {
                    EmbedBuilder Embed = new EmbedBuilder();
                    Embed.WithColor(255, 0, 0);
                    Embed.WithTitle($"{Title}");
                    Embed.WithDescription($"{Desc}");
                    Embed.WithCurrentTimestamp();
                    Embed.WithThumbnailUrl($"{Thumbnail}");
                    var chnl = _client.GetChannel(ChannelID) as IMessageChannel;
                    await chnl.SendMessageAsync("", false, Embed.Build());
                }
            }
            catch { }
        }
        private static async Task MessageReceived(SocketMessage message)
        {
            if (message.Author.IsBot) { return; }

            if (message.Content == "!about")
            {
                await message.Channel.SendMessageAsync("```SED is a platform focused on merging markets. both mobile and online. The main focus is on quality, maintainability and stability.\nWhy is SED so special? It uses clean architectures which is by far more porefull, advanced , performance and security! Also SED is developed under the concept \"quality over quantity\".```");

                await SendEmbed(message.Channel.Id, "Dr.Mahmoud Elshewimy", "Supervisor", "Project supervisor.", "http://i.epvpimg.com/rgRufab.png", "http://i.epvpimg.com/rgRufab.png");
                await SendEmbed(message.Channel.Id, "Mohamed Shehata", "Mobile Developer", "Leader and mobile developer.", "http://i.epvpimg.com/tRsTeab.png", "http://i.epvpimg.com/tRsTeab.png");
                await SendEmbed(message.Channel.Id, "Mahmoud Hafez", "Mobile Developer", "Mobile Developer.", "http://i.epvpimg.com/y6anfab.png", "http://i.epvpimg.com/y6anfab.png");
                await SendEmbed(message.Channel.Id, "Abdullah Ragab", "Back end Developer", "Back end Developer.", "http://i.epvpimg.com/EKVpeab.png", "http://i.epvpimg.com/EKVpeab.png");
                await SendEmbed(message.Channel.Id, "Mahmoud Elamrosy", "Back end Developer", "Back end Developer.", "http://i.epvpimg.com/ioIcfab.png", "http://i.epvpimg.com/ioIcfab.png");
                await SendEmbed(message.Channel.Id, "Mohamed Adel (Firmeno)", "Front End Developer", "Front end Developer.", "http://i.epvpimg.com/vTCgeab.png", "http://i.epvpimg.com/vTCgeab.png");
                await SendEmbed(message.Channel.Id, "Abdelrahaman ezzat", "Front End Developer", "Front End Developer.", "http://i.epvpimg.com/hB5oeab.png", "http://i.epvpimg.com/hB5oeab.png");


            }
        }
    }
}
