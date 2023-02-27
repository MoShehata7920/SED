namespace Database.Context.SEDDb
{
    public partial class _Sections
    {
        public int ID { get; set; }
        public string? Name { get; set; }
        public virtual ICollection<_Items> Items { get; set; } = new List<_Items>();
    }
}