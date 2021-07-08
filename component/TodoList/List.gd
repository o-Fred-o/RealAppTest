extends VBoxContainer

const TASK_ITEM := preload("res://component/TodoList/Task.tscn")

onready var list_container := $ScrollContainer/TasksContainer

var myList : ListModel
var list_file = "res://task_list.dat"

func _ready():
    Events.connect("task_add", self, "_add_task_to_list")
    Events.connect("task_remove", self, "_on_remove_task_from_list")
    Events.connect("list_save", self, "_on_list_save_to_file")
    _load_list_from_file()

#revoir la fonction, on peu optimiser ?
func _add_task_to_list(task : TaskModel):
    if !task.description.empty():
        var task_item = TASK_ITEM.instance()
        task_item.description=task.description
        task_item.myTask=task
        list_container.add_child(task_item)
        #ajoute la donne au modele
        #mise a jour de l'id
        task.id=task_item.get_instance_id()
        myList.add_task(task)
    
func _on_remove_task_from_list(task : TaskModel):
    instance_from_id(task.id).queue_free()
    #supprime l'element du model liste
    myList.remove_task(task)
    
func _on_list_save_to_file():
    var file = File.new()
    file.open(list_file, File.WRITE)
    var node_data = myList.call("save")
    file.store_line(to_json(node_data))
    file.close()
    print("save list OK")
    
func _load_list_from_file():
    var file = File.new()
    if file.file_exists(list_file):
        file.open(list_file, File.READ)
        while file.get_position() < file.get_len():
            var list_data = parse_json(file.get_line())
            myList = ListModel.new(1,[])
            for i in list_data.keys():
                if i == "tasks":
                    var task_data = list_data[i]
                    for j in task_data:
                        #ajoute les task a la liste
                        var newTask=TaskModel.new(task_data[j].id,task_data[j].description)
                        _add_task_to_list(newTask)
        file.close()
        print("load list OK")
    else:
        #si pas de fichier creation d'une nouvelle liste
        myList = ListModel.new(1,[])
        print("create new list OK")
