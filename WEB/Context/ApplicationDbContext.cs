using CreatingKanbanSample.Data;
using Microsoft.EntityFrameworkCore;
namespace CreatingKanbanSample.Context
{
    public class ApplicationDbContext :DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) 
            : base(options) 
        {
            
        }
        public DbSet<KanbanModel> KanbanModel { get; set; }
    }
}
