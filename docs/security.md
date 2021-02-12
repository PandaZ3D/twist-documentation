# Twist Security

uses capabilities to enforce access to:

* modify a namespace
* read/write tags
* delete things

## Tag Permissions
`policy` var delegates how capabilities are enforced

* Read/write are the only access permissions
* Delete is special for removing tags
* Object access supersedes all other accesses (namespace, tag)
* Policy bits
  * `r | w | z | o | n`
  * `(r/w/z)` read/write/delete
    * public permissions for tag
  * (o) object access 
    * Only (r/w/z) permission bits considered
    * Object’s permission bits always considered
    * If o and n bit is set, then we need access to obj and ns
  * (n) namespace access 
    * Only (r/w/z) permission bits considered
    * If z bit is set, then only local tags can be deleted
* What does a 0 mean for n and o?
  * Access to this resource is not necessary to access tag
  * It might be allowed (e.g. object access)
* What does a 1 mean for n and o?
  * Access to this resource is necessary to access tag
* List of policy permissions (from least to most restrictive)
  * Public permission bits set
  * n = 1 and access to ns
  * o = 1 and access to obj
  * n = 1 and o = 1, access to ns and obj needed
* What does r/w/z access mean?
  * r: you can read the tag
  * w: you can modify the tag
    * Change permissions
    * Change value attr
    * Change policy
  * z: you can delete the tag
* Access to a tag calculated as:
```python
access_bits(object, cap) = ro | wo | zo
access_bits(namespace, cap) = rn | wn | zn
access_bits(tag.policy) = rt | wt | zt
r = rt | ro & ~(n & o) | ro & rn & (n & o) | rn & (n & ~o) 
w = # same logic as above
z = zt | zo & ~(n & o) | zo & zn & (n & o) | zn & (n & ~o) & tag.local
#  Can delete if tag is local and you can remove namespace
```
## Link Permissions
Need security API for this. Still thinking about it.

links exists in shared permission groups

- per object global metadata lives somewhere
	- tags + links
- different groups exists for different permissions
	- (r/w/z) read/write/delete
		- each of these indicate the default permissions
	- a group may have no default permissions
		- in the case of tags protected by capabilities
		- plus policy which is enforced by API
	- protected by capabilities as well since they 
		- live in the same object
	- permission groups are objects
		- stores metadata entries
		- has default permissions (read-only) and 
			- protected by capabilities
			- only API can change this (need rw access)
- local instances of links or tags may have their own policy

what does r/w/z mean??

- r: read the metadata
- w: change the metadata
- z: delete the metadata

### Questions

* not sure if tags should be in their own protection groups since the enforcement of permissions are semantically different?
