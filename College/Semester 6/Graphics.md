```dataview
TABLE 
    priority AS "Priority", 
    status AS "Status", 
    link(contexts) AS "Context",
    due AS "Due"
FROM "TaskNotes"
WHERE contains(contexts, "Graphics")
SORT 
    (striptime(due)) DESC,
    priority ASC
```
---
```dataview
List
FROM "College/Semester 6/Notes" AND #graphics
```
