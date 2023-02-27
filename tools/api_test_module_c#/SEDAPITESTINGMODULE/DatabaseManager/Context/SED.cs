using Database.Context.SEDDb;
using Microsoft.EntityFrameworkCore;

namespace Database.Context
{
    public partial class SED : DbContext
    {
        public SED()
        {
        }

        public SED(DbContextOptions<SED> options)
            : base(options)
        {
        }

        public virtual DbSet<_Users> UsersTable { get; set; }
        public virtual DbSet<_Carousel> CarouselImages { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
       => optionsBuilder.UseSqlServer(DatabaseManager.SEDConnectionString);

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<_Users>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo.ID");

                entity.ToTable("_Users");

                entity.Property(e => e.Email).HasMaxLength(100);

                entity.Property(e => e.Password).HasMaxLength(100);

                entity.Property(e => e.Password).HasMaxLength(100);

                entity.Property(e => e.Phone).HasMaxLength(15);

            });

            modelBuilder.Entity<_Carousel>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo.ID2");

                entity.Property(e => e.Image).HasMaxLength(1000);

                entity.ToTable("_Carousel");

            });
            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
