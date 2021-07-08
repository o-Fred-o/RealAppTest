extends VBoxContainer

var db
var db_name := "res://data/test"

var user_table := "user"
var user_dict : UserDict

func _ready():
    db = Global.SQLite.new()

    db.path = db_name
    db.verbose_mode = true
    # Open the database using the db_name found in the path variable
    db.open_db()
    # Throw away any table that was already present
    db.drop_table(user_table)
    # Create a table with the structure found in table_dict and add it to the database
    var user_dict = UserDict.new()
    db.create_table(user_table, user_dict.structure)
    user_dict.add_data()

    print(user_dict.data)
    db.insert_row(user_table, user_dict.data)
    
    db.query("SELECT * FROM " + user_table + ";")
    print(db.query_result)
    
    db.query("SELECT name FROM sqlite_master WHERE type ='table' AND name NOT LIKE 'sqlite_%';")
    print(db.query_result)
    
    db.query("PRAGMA table_info("+ user_table + ");")
    print(db.query_result)
    
    db.close_db()
