namespace Database.Context.SEDDb
{
    public partial class _Items
    {
        public int ID { get; set; }
        public string? Name { get; set; }
        public string? Descr { get; set; }
        public string? Image { get; set; }
        public int? Price { get; set; }
        public int Category_Id { get; set; }
        public int Section_Id { get; set; }
        public _Categories? Category { get; set; }
        public _Sections? Section { get; set; }
    }
}