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
        public virtual DbSet<_Categories> Categories { get; set; }
        public virtual DbSet<_Sections> Sections { get; set; }
        public virtual DbSet<_Items> Items { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
       => optionsBuilder.UseSqlServer(DatabaseManager.SEDConnectionString);

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<_Users>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo._Users_ID");

                entity.ToTable("_Users");

                entity.Property(e => e.Email).HasMaxLength(100);

                entity.Property(e => e.Password).HasMaxLength(100);

                entity.Property(e => e.Password).HasMaxLength(100);

                entity.Property(e => e.Phone).HasMaxLength(15);

            });

            modelBuilder.Entity<_Carousel>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo._Carousel_ID");

                entity.Property(e => e.Image).HasMaxLength(1000);

                entity.ToTable("_Carousel");

            });

            modelBuilder.Entity<_Categories>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo._Categories_ID");

                entity.Property(e => e.Name).HasMaxLength(100);

                entity.HasMany(c => c.Items).WithOne(e => e.Category)
                                   .HasForeignKey(d => d.Category_Id)
                                   .OnDelete(DeleteBehavior.ClientSetNull)
                                   .HasConstraintName("FK_dbo._Categories._Categories_ID");

                entity.Property(e => e.Image).HasMaxLength(1000);

                entity.ToTable("_Categories");

            });

            modelBuilder.Entity<_Sections>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo._Sections_ID");

                entity.Property(e => e.Name).HasMaxLength(100);


                entity.HasMany(c => c.Items).WithOne(e => e.Section)
                                   .HasForeignKey(d => d.Section_Id)
                                   .OnDelete(DeleteBehavior.ClientSetNull)
                                   .HasConstraintName("FK_dbo._Categories._Sections_ID");

                entity.ToTable("_Sections");

            });

            modelBuilder.Entity<_Items>(entity =>
            {
                entity.HasKey(e => e.ID).HasName("PK_dbo._Items_ID");

                entity.Property(e => e.Name).HasMaxLength(100);

                entity.Property(e => e.Image).HasMaxLength(1000);

                entity.Property(e => e.Descr).HasMaxLength(1000);

                entity.ToTable("_Items");

            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
