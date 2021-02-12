## Object Names

Names are used to refer to objects, they are simply a special type of tag whose key is reserved by the system.

__Name Operations__
```python
'''
 params:
   parent_ns - reference to namespace name will be stored
   obj_name - string that will be used to refer to obj_id
   obj_id - unique identifier that refers to object
   flags - (optional) flags
 returns:
   namespace - reference to namespace
   status - success/failure code
'''
add_name(parent_ns, obj_name, obj_id, cap, flags) → status
# 	registers a (obj_name, obj_id) pair within parent_ns
#
#	initially this object in the namespace has no tags
# 	associated with it, so it is created with a unique
#	version tag with value equal to the object id
#
#	internal call modify_tag()

# modify name?????

'''
params:
   parent_ns - (optional) reference to namespace name will be stored
   tag_list - list of tags that will help identify object
	   * tags are simply kv-pairs provided by the user
	   * one of those tags are the obj_name string
   flags - (optional) flags:
     * name refers to a namespace
 returns:
   obj_id - reference to object we are interested in
   status - success or failure code:
	   * name might not exist
	   * tag_list does not narrow down search
'''
get_name(parent_ns, tag_list, flags) → obj_id, status
# 	looks up a name within a namespace to find an obj_id
#
# a unique set of tags will help identify an object
#	with an internal call to get_by_tags()

change_name()
#	used to rename an object registered in the ns
#	changes the mapping new -> id

delete_name()
#	delete name -> objid mapping
#	delete unique (non-global) tags in namespace
```

### Comments
* writes which are duplicates: idempotent
* unique: objid, nsid, key, and value
  * value is needed because we might want to have two names point the same object
  * can we have a thing where we don'y need the value??
* should values in tags be versioned?? idk wait to think about that
* need a delete function
* links could be implemented as tags

### Questions

* how do we make sure that we do not overwrite names?
* how do we make sure we map unique things
* do we need to enforce capabilties here?
  * for naming, they are essetially tags ...
  * I can see the case for change/delete
  * get_name is interesting
  * do we need special permissions to add a name?
    * atleast to the namespace
* not sure if we need seperate name and tag APIs
