using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SEDAPITESTINGMODULE.DatabaseManager.Migrations
{
    /// <inheritdoc />
    public partial class _2023_02_27 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "_Carousel",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Image = table.Column<string>(type: "nvarchar(1000)", maxLength: 1000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dbo._Carousel_ID", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "_Categories",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Image = table.Column<string>(type: "nvarchar(1000)", maxLength: 1000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dbo._Categories_ID", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "_Sections",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dbo._Sections_ID", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "_Users",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Password = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Phone = table.Column<string>(type: "nvarchar(15)", maxLength: 15, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dbo._Users_ID", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "_Items",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Descr = table.Column<string>(type: "nvarchar(1000)", maxLength: 1000, nullable: true),
                    Image = table.Column<string>(type: "nvarchar(1000)", maxLength: 1000, nullable: true),
                    Price = table.Column<int>(type: "int", nullable: true),
                    Category_Id = table.Column<int>(type: "int", nullable: false),
                    Section_Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dbo._Items_ID", x => x.ID);
                    table.ForeignKey(
                        name: "FK_dbo._Categories._Categories_ID",
                        column: x => x.Category_Id,
                        principalTable: "_Categories",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_dbo._Categories._Sections_ID",
                        column: x => x.Section_Id,
                        principalTable: "_Sections",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateIndex(
                name: "IX__Items_Category_Id",
                table: "_Items",
                column: "Category_Id");

            migrationBuilder.CreateIndex(
                name: "IX__Items_Section_Id",
                table: "_Items",
                column: "Section_Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "_Carousel");

            migrationBuilder.DropTable(
                name: "_Items");

            migrationBuilder.DropTable(
                name: "_Users");

            migrationBuilder.DropTable(
                name: "_Categories");

            migrationBuilder.DropTable(
                name: "_Sections");
        }
    }
}
