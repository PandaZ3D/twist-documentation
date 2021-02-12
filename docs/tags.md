# Object Tags

Tags are tuples `(obj_id, ns_id, key, value, policy)` that are used to uniquely identify objects and organize them to make searches more efficient. They contain: a reference to the object (`obj_id`) they are tied to, a reference to the namespace (`ns_id`) they belong to, a description of the tag (`key`), the attribute `value`, and the `policy` used to access control. The tag `key` is implemented as a human readable string, while the tag `value` is implemented as a byte string. Tags are protected by capabilities which are enforced based on the `policy`. Capabilities along with the `policy` flage are described in the [security section][security]. Users do not need to provide capabilities in some cases.

__Tag Properties__

There are two types of tags recognized by Twist: user defined tags and tags used by the system to implement features. The tags used by the system are tags whose keys are reserved, indicated by two underscores. Tag values, however, are user defined. 

Examples of reserved tag keys are:

* `__name`
* `__version`
* `__type`
* `__link`

The `__type` key is the only tag whose value can only be `namespace` or `object_name`. It is used for the system to differentiate between objects that are namespaces and user objects.

The scope of an object depends on the namespace it belongs to. Tags can be globally tied to an object (e.g. `ns_id = 0`). Alternatively a tag can be a local instance relative to a particular namespace.

__Tag Operations__

* create_tag
  * adds a new tag entry to the namespace
* modify_tag
  * updates one or more tag fields
    * used to change key or update value
    * can change permission, namespace, object
* delete_tag
  * deletes the tag entry from namespace
* access_tag


__Tag Queries__

* find_object
  * by tags (generic query interface)
    * by owner
    * by name
* conjunctive queries for now (AND only)

## create_tag
`create_tag(ns_id, obj_id, tag_key, tag_val, policy, cap, flags)` &rarr; `status`

Creates a new tag relative to `ns_id`.

__Input Parameters__

* `ns_id` - unique identifier that refers to namespace
* `obj_id` - unique identifier that refers to object
* `tag_key` - string used to describe attribute
* `tag_val` - tag value that describes object
* `policy` - (optional) permission bits for tag
* `cap` - (optional) capability used to verify permissions
* `flags` - (optional) flags:
  * Use default tag permissions. Ignores `policy` value.

Global tags are created if the value of `ns_id` is 0. Otherwise a local tag relative to the `ns_id` is created. 

__Return Value(s)__

* `status` - success/failure code:
  * permission error
  * object does not exist
  * tag already exists

```python
'''
 params:
   parent_ns - reference to namespace name will be stored
   obj_id - unique identifier that refers to object
   tag_key - string used to describe attribute
   tag_val - tag value that refers to object
   cap - (optional) capability used to verify permissions
   flags - (optional) flags:
	   * tag is registered globally or locally 
	   * creating or modifying (write) a tag
	   * change the policy
 returns:
   status - success/failure code:
	   * permission error
	   * tag does not exist (write)
'''
modify_tag(parent_ns, obj_id, key, value, cap, flags)
#	used to create/write tag attributes which refer to an object
#	
#	policy for enforcing capabilities stored in metadata

who initially creates the policy var for a tag???

'''
 params:
   parent_ns - reference to namespace name will be stored
   obj_id - unique identifier that refers to object
   tag_key - string used to describe attribute
   tag_val - tag value that refers to object
   cap - (optional) capability used to verify permissions
   flags - (optional) flags:
	   * global or local search
 returns:
   status - success/failure code:
	   * permission error
	   * tag does not exist
'''
read_tag(parent_ns, obj_id, key, value, cap, flags)
#	used to read value of a tag for a specific object
#	has implicit verify call for capability
#	policy for enforcing capabilities stored in metadata

'''
 params:
   parent_ns - reference to namespace name will be stored
   obj_id - unique identifier that refers to object
   tag_list - list of tags that will help identify object
	   * tags are simply kv-pairs provided by the user
		   * tag_key - string used to describe attribute
		   * tag_val - tag value that refers to object
   cap - (optional) capability used to verify permissions
   flags - (optional) flags:
	   * global or local search
 returns:
   status - success/failure code:
	   * permission error
	   * tag does not exist
'''
get_by_tags(parent_ns, tag_list, flags) → [name_1 ... name_n], status
#	used to return a list of candidate objects 
#	(obj_name, obj_id) pairs that are tagged 
#	with tags in tag_list
#
#	

will this leak information?
not sure if this needs capaibilities used to read tags/objids
can we just trust the NRS to read this only??
some of these tags may be _global ... do we refer to this somehow??

```

## Comments

* we can use the `get_by_tags` to essentially implement everything else
  * needs to be designed correctly, allow many types of queries
* some queries might have incomplete information
  * in the case where we do not know the object id
  * the user could only provide hints through tags
    * lists what objects do

## Questions

* what other types of queries can be made other than conjunctive?
  * something like `find al*` (names that start with `al`)
    * regex-like query
    * range query
  * find object (s) owned by someone
* should `modify_tag` be changed, it seems to be doing so much
  * a single call can change many things
  * not sure if atomicity can be ensured
  * maybe a `move_tag` call for namespace, policy, and object changes
