using Database.Context.SEDDb;
using Microsoft.EntityFrameworkCore;
using Models;
using System.Text.Json;
using WatsonWebserver;
using Webserver;
using HttpMethod = WatsonWebserver.HttpMethod;

namespace Library.Webserver;

public class WebserverManager : IWebserverManager
{
    static JsonSerializerOptions options = new JsonSerializerOptions()
    {
        WriteIndented = true
    };

    private WatsonWebserver.Server _server;
    private List<string> _protectedRoutes;

    public WebserverManager()
    {
        Start("103.48.193.225", 9000);
    }

    public void Start(string hostname, int port)
    {
        _protectedRoutes = new List<string>();
        _server = new WatsonWebserver.Server("*", port, false, DefaultRoute);
        _server.Routes.PreRouting = PreRoutingHandler;
        _server?.Start();
    }

    private Task<bool> PreRoutingHandler(HttpContext ctx)
    {
        var needsAuth = false;
        if (_protectedRoutes == null)
        {
            // block access because we cannot verify if the route is legit or not
            return Task.FromResult(true);
        }

        foreach (var unused in _protectedRoutes.Where(protectedRoute => ctx.Request.Url.RawWithQuery.ToLower().StartsWith(protectedRoute)))
        {
            needsAuth = true;
        }

        // TODO :: implement JWT auth

        return Task.FromResult(false); // allow the connection
    }

    public void Stop()
    {
        _server?.Stop();
        _server = null;
    }

    public void addProtectedPrefix(string path)
    {
        _protectedRoutes?.Add(path);
    }

    public void addStaticRoute(HttpMethod method, string path, Func<HttpContext, Task> handler)
    {
        _server?.Routes.Static.Add(method, path, handler);
    }

    public void addStaticRoute(string path, Func<HttpContext, Task> handler)
    {
        addStaticRoute(HttpMethod.GET, path, handler);
    }

    public void removeStaticRoute(HttpMethod method, string path)
    {
        _server?.Routes.Static.Remove(method, path);
    }

    public void removeStaticRoute(string path)
    {
        removeStaticRoute(HttpMethod.GET, path);
    }

    public void addParameterRoute(HttpMethod method, string path, Func<HttpContext, Task> handler)
    {
        _server?.Routes.Parameter.Add(method, path, handler);
    }

    public void addParameterRoute(string path, Func<HttpContext, Task> handler)
    {
        addParameterRoute(HttpMethod.GET, path, handler);
    }

    public void removeParameterRoute(HttpMethod method, string path)
    {
        _server?.Routes.Parameter.Remove(method, path);
    }

    public void removeParameterRoute(string path)
    {
        removeParameterRoute(HttpMethod.GET, path);
    }

    static async Task DefaultRoute(HttpContext ctx)
    {
        ctx.Response.StatusCode = 200;
        await ctx.Response.Send("It works!");
    }

    [StaticRoute(HttpMethod.POST, "/customers/login")]
    public static async Task Login(HttpContext ctx)
    {
        //logging
        Extensions.WriteLineAsync($"RECEIVED REQUEST AT [/customers/login]\n{ctx.Request.DataAsString}", ConsoleColor.Yellow);

        //get request
        var req = ctx.Request.DataAsJsonObject<Login>();

        //check if the incrediants are correct
        using var db = new Database.Context.SED();

        var res = new LoginResponse
        {
            status = 0,
            message = "Successfully Logged In",
            token = Utils.generateToken()
        };

        if (await db.UsersTable.AnyAsync(x => x.Email == req.email && x.Password == req.password))
        {
            Extensions.WriteLineAsync($"User {req.email} Logged in successfully", ConsoleColor.Green);

            res.status = 0;
        }
        else
        {
            Extensions.WriteLineAsync($"User {req.email} failed to login", ConsoleColor.Red);
            res.status = 1;
            res.message = "Email or password are wrong!";
        }

        string jsonString = JsonSerializer.Serialize(res, options);

        ctx.Response.ContentType = "application/json";
        ctx.Response.StatusCode = 200;
        await ctx.Response.Send(jsonString);
    }

    [StaticRoute(HttpMethod.POST, "/customers/register")]
    public static async Task Register(HttpContext ctx)
    {
        //logging
        Extensions.WriteLineAsync($"RECEIVED REQUEST AT [/customers/Register]\n{ctx.Request.DataAsString}", ConsoleColor.Yellow);

        //get request
        var req = ctx.Request.DataAsJsonObject<Register>();

        //check if the incrediants are correct
        using var db = new Database.Context.SED();

        var res = new LoginResponse
        {
            status = 0,
            message = "User registered successfully",
            token = Utils.generateToken()
        };

        if (await db.UsersTable.AnyAsync(x => x.Email == req.email))
        {
            Extensions.WriteLineAsync($"User {req.email} already registered.", ConsoleColor.Red);

            res.status = 1;
            res.message = $"User {req.email} already registered.";
        }
        else
        {
            Extensions.WriteLineAsync($"User {req.email} successfully registered", ConsoleColor.Green);

            res.status = 0;
            res.message = "user registered successfully!";

            var users = new _Users
            {
                Email = req.email,
                Password = req.password,
                Phone = req.mobile_number,
                Username = req.user_name,
            };

            db.UsersTable.Add(users);

            await db.SaveChangesAsync();
        }

        string jsonString = JsonSerializer.Serialize(res, options);

        ctx.Response.ContentType = "application/json";
        ctx.Response.StatusCode = 200;
        await ctx.Response.Send(jsonString);
    }

    [StaticRoute(HttpMethod.POST, "/customers/forgotPassword")]
    public static async Task ForgotPassword(HttpContext ctx)
    {
        //logging
        Extensions.WriteLineAsync($"RECEIVED REQUEST AT [/customers/forgotPassword]\n{ctx.Request.DataAsString}", ConsoleColor.Yellow);

        //get request
        var req = ctx.Request.DataAsJsonObject<ForgotPassword>();

        //check if the incrediants are correct
        using var db = new Database.Context.SED();

        var res = new ForgotResponse
        {
            status = 0,
            message = "success",
            support = $"We have sent an email to {req.email}"
        };

        if (await db.UsersTable.AnyAsync(x => x.Email == req.email))
        {
            Extensions.WriteLineAsync($"User {req.email} resetted password succesffully", ConsoleColor.Green);

            res.status = 0;
        }
        else
        {
            Extensions.WriteLineAsync($"User {req.email} failed to reset password", ConsoleColor.Red);
            res.status = 1;
            res.message = "Email seems to be wrong!";
        }

        string jsonString = JsonSerializer.Serialize(res, options);

        ctx.Response.ContentType = "application/json";
        ctx.Response.StatusCode = 200;
        await ctx.Response.Send(jsonString);
    }


    [StaticRoute(HttpMethod.GET, "/main/home")]
    public static async Task GetHomeData(HttpContext ctx)
    {
        //logging
        Extensions.WriteLineAsync($"RECEIVED REQUEST FROM: [{ctx.Request.Source.IpAddress}] AT [/main/home]", ConsoleColor.Yellow);

        //get request

        using var db = new Database.Context.SED();

        var homeCarouselImages = await db.CarouselImages.ToListAsync();
        var homeCategories = await db.Categories.ToListAsync();
        var homeSections = await db.Sections.ToListAsync();
        var homeItems = await db.Items.ToListAsync();

        var homeRequest = new HomeResponse();

        homeRequest.status = 0;

        homeRequest.message = "Successfully loaded data";

        foreach (var entry in homeCarouselImages)
        {
            homeRequest.carousel.Images.Add(entry.Image);
        }

        foreach (var entry in homeCategories)
        {
            var categoryEntity = new Categories
            {
                ID = entry.ID,
                Name = entry.Name,
                Image = entry.Image,
            };

            homeRequest.categories.Add(categoryEntity);
        }

        var sellItems = homeItems.Where(x => x.Section_Id == 1).OrderByDescending(x => x.ID).Take(10);

        foreach (var item in sellItems)
        {
            var sellItem = new Item
            {
                Image = item.Image,
                Descr = item.Descr,
                Name = item.Name,
                Price = item.Price
            };

            homeRequest.sellItems.Add(sellItem);
        }

        var donateItems = homeItems.Where(x => x.Section_Id == 2).OrderByDescending(x => x.ID).Take(10);

        foreach (var item in donateItems)
        {
            var donateItem = new Item
            {
                Image = item.Image,
                Descr = item.Descr,
                Name = item.Name,
                Price = item.Price
            };

            homeRequest.donateItems.Add(donateItem);
        }

        var exchangeItems = homeItems.Where(x => x.Section_Id == 3).OrderByDescending(x => x.ID).Take(10);

        foreach (var item in exchangeItems)
        {
            var exchangeItem = new Item
            {
                Image = item.Image,
                Descr = item.Descr,
                Name = item.Name,
                Price = item.Price
            };

            homeRequest.exchangeItems.Add(exchangeItem);
        }

        string jsonString = JsonSerializer.Serialize(homeRequest, options);

        Extensions.WriteLineAsync($"{jsonString}", ConsoleColor.Magenta);

        ctx.Response.ContentType = "application/json";
        ctx.Response.StatusCode = 200;
        await ctx.Response.Send(jsonString);
    }

}