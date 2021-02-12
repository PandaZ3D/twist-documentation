## Links

Links are references to other objects. They can be used to express relationships between objects. Examples of relationships are:

* dependencies
* versioning
* indexing 

links are tuples of `(srcid, dstid, flags)`. The used object ids instead of names.

- `srcid` and `dstid` are object ids
- `flags = type | dir`
	- `type`: indicates the type of link
		- what the link is pointing to (dstid)
    - what kind of relationship they share
	- `dir`: link direction bit
		- links are unidirectional

still thinking about this (might need cap argument)

__Link Operations__

- add_link(ns_id, src_id, dst_id, flags)
	- ns_id indicates permission group/namespace
	- flags tells us loca/global link
- delete_link(ns_id, src_id, dst_id, flags)
	- flags tells us if we are doing local/global
- get_links(ns_id, obj_id, flags)
