using CreatingKanbanSample.Context;
using Microsoft.EntityFrameworkCore;

namespace CreatingKanbanSample.Data
{
    public class ToDoService
    {
        private readonly ApplicationDbContext _applicationDbContext;

        public ToDoService(ApplicationDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }

        // Get All KanbanModel List
        public async Task<List<KanbanModel>> GetAllToDo()
        {
            try
            {
                return await _applicationDbContext.KanbanModel.ToListAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving ToDo items: {ex.Message}");
                throw;
            }
        }

        // Add New ToDo Record
        public async Task<bool> AddNewToDo(KanbanModel kanbanModel)
        {
            try
            {
                // Mencari nomor urut terbesar yang sudah ada
                var lastKanban = await _applicationDbContext.KanbanModel
                                    .OrderByDescending(k => k.Id)
                                    .FirstOrDefaultAsync();

                int nextNumber = 1;

                if (lastKanban != null)
                {
                    // Mengambil nomor urut terakhir dari activity_no yang ada
                    var lastNumberStr = lastKanban.Id.ToString().Replace("AC - ", "");
                    if (int.TryParse(lastNumberStr, out int lastNumber))
                    {
                        nextNumber = lastNumber + 1;
                    }
                }

                // Set nilai activity_no dengan format yang unik
                kanbanModel.activity_no = $"AC - {nextNumber.ToString("D4")}"; // D4 untuk padding 4 digit (AC - 0001, AC - 0002, dst)

                // Menambahkan ke database
                await _applicationDbContext.KanbanModel.AddAsync(kanbanModel);
                await _applicationDbContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error adding new ToDo item: {ex.Message}");
                return false;
            }
        }

        // Get ToDo Record By Id
        public async Task<KanbanModel> GetToDoById(int Id)
        {
            try
            {
                return await _applicationDbContext.KanbanModel.FirstOrDefaultAsync(x => x.Id == Id);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving ToDo item by Id: {ex.Message}");
                return null; 
            }
        }

        // Update ToDo Data
        public async Task<bool> UpdateToDoDetails(KanbanModel kanbanModel)
        {
            try
            {
                var existingTask = await _applicationDbContext.KanbanModel.FindAsync(kanbanModel.Id);

                if (existingTask != null)
                {
                    existingTask.Title = kanbanModel.Title;
                    existingTask.Status = kanbanModel.Status;
                    existingTask.Summary = kanbanModel.Summary;

                    await _applicationDbContext.SaveChangesAsync();
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating ToDo item: {ex.Message}");
                return false;
            }
        }

        // Delete ToDo Data
        public async Task<bool> DeleteToDo(KanbanModel kanbanModel)
        {
            try
            {
                var existingTask = await _applicationDbContext.KanbanModel.FindAsync(kanbanModel.Id);

                if (existingTask != null)
                {
                    _applicationDbContext.KanbanModel.Remove(existingTask);
                    await _applicationDbContext.SaveChangesAsync();
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting ToDo item: {ex.Message}");
                return false;
            }
        }
    }
}
