### Versions

Versions become read-only once they are marked. Linear and non-linear versioning is supported, however, versions are manage by the application. Still thinking about this.

__Version Operations__
```python
'''
params:
   parent_ns - reference to namespace version will be stored
   obj_id - reference to object version belongs to
   tag_value - the name of this version
   cap - (optional) capability used to verify permissions
   flags - (optional) flags:
	   * version can exist globally or locally
 returns:
   obj_id - reference to new object (COW) of old
   status - success or failure code
'''
mark_version(parent_ns, obj_id, tag_value, cap, flags)
#	marks this object as a read-only instance and
#	tags it with (__version, tag_value) kv
#	implicit call to modify_tag for object

delete_version()
```

### Questions

* should versions global or local?
* what happens when you delete a version?
