class_name ListModel extends Object

var id : int
var tasks : Array = []

func _init(_id: int, _tasks: Array):
    id=_id
    tasks = []

func add_task( task : TaskModel):
    tasks.push_back(task)

#todo erase
func remove_task( task : TaskModel):
    tasks.erase(task)

func save():
    var task_list = {}
    
    for task in tasks:
        task_list[task] = task.call("save")
    
    var save_dict= {
        "id" : id,
        "tasks" : task_list
       }
    return save_dict
