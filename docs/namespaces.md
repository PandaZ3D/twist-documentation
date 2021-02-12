## Namespaces

an object that stores mapping from name to object id

```python
'''
 params:
   parent_ns - (optional) reference to namespace ns_name is in
   ns_name - string name refering to namespace
   cap - (optional) capability used to verify permissions
   flags - (optional) flags
 returns:
   child_ns - reference to namespace
   status - success/failure code
'''
open_namespace(parent_ns, ns_name, cap, flags) → status, child_ns
#	returns a reference by name relative to the current namespace
# 	  or parent_ns 
#	reference to current namespace implicit to system (similar to env var)
# 	internally calls Twist name resolver and invokes a name lookup

'''
 params:
   namespace - (optional) reference to namespace ns_name is in
   flags - (optional) flags
 returns:
   status - success/failure code
'''
close_namespace(namespace, flags) -> status
delete_namespace(namespace, flags)
```