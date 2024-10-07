using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CreatingKanbanSample.Data
{
    public class KanbanModel
    {
        [Key]
        public int Id { get; set; }
        public string Title { get; set; }
        public string Status { get; set; }
        public string Summary { get; set; }
    }
}
