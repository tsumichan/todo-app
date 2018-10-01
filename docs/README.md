## データ構造

### task_model
- id(integer)
- title(string)
- description(string)
- due_at(datetime)
- status(integer)
- priority(integer)
- created_at(datetime)
- updated_at(datetime)
- user_id(integer)

### user_model
- id(integer)
- name(string)
- role(integer)
- created_at(datetime)
- updated_at(datetime)
- password_digest(string)
- tasks_count(integer)

### task_label_model
- id(integer)
- task_id(integer)
- label_id(integer)
- created_at(datetime)
- updated_at(datetime)

### label_model
- id(integer)
- name(string)
- created_at(datetime)
- updated_at(datetime)
- user_id(integer)
