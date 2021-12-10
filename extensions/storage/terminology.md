---
title: "Terminology"
date: 2018-05-02T00:00:00+00:00
weight: 17
geekdocRepo: https://github.com/owncloud/ocis
geekdocEditPath: edit/master/docs/extensions/storage
geekdocFilePath: terminology.md
---

Communication is hard. And clear communication is even harder. You may encounter the following terms throughout the documentation, in the code or when talking to other developers. Just keep in mind that whenever you hear or read *storage*, that term needs to be clarified, because on its own it is too vague. PR welcome.

## Logical concepts

### Resources
A *resource* is the basic building block that oCIS manages. It can be of [different types](https://cs3org.github.io/cs3apis/#cs3.storage.provider.v1beta1.ResourceType):
- an actual *file*
- a *container*, e.g. a folder or bucket
- a *symlink*, or
- a [*reference*]({{< ref "#references" >}}) which can point to a resource in another [*storage provider*]({{< ref "#storage-providers" >}})

### References
A *reference* identifies a [*resource*]({{< ref "#resources" >}}). A [*CS3 reference*](https://cs3org.github.io/cs3apis/#cs3.storage.provider.v1beta1.Reference) can carry a *path* and a [CS3 *resource id*](https://cs3org.github.io/cs3apis/#cs3.storage.provider.v1beta1.ResourceId). The references come in two flavors: absolute and combined.
Absolute references have either the *path* or the *resource id* set:
- An absolute *path* MUST start with a `/`. The *resource id* MUST be empty.
- An absolute *resource id* uniquely identifies a [*resource*]({{< ref "#resources" >}}) and is used as a stable identifier for sharing. The *path* MUST be empty.
Combined references have both, *path* and *resource id* set:
- the *resource id* identifies the root [*resource*]({{< ref "#resources" >}})
- the *path* is relative to that root. It MUST start with `.`
## References

A *reference* is a logical concept that identifies a [*resource*]({{< ref "#resources" >}}). A [*CS3 reference*](https://cs3org.github.io/cs3apis/#cs3.storage.provider.v1beta1.Reference) consists of either
- a *path* based reference, used to identify a [*resource*]({{< ref "#resources" >}}) in the [*namespace*]({{< ref "./namespaces.md" >}}) of a [*storage provider*]({{< ref "#storage-providers" >}}). It must start with a `/`.
- a [CS3 *id* based reference](https://cs3org.github.io/cs3apis/#cs3.storage.provider.v1beta1.ResourceId), uniquely identifying a [*resource*]({{< ref "#resources" >}}) in the [*namespace*]({{< ref "./namespaces.md" >}}) of a [*storage provider*]({{< ref "#storage-providers" >}}). It consists of a `storage provider id` and an `opaque id`. The `storage provider id` must NOT start with a `/`.

{{< hint info >}}
The `/` is important because currently the static [*storage registry*]({{< ref "#storage-space-registries" >}}) uses a map to look up which [*storage provider*]({{< ref "#storage-providers" >}}) is responsible for the resource. Paths must be prefixed with `/` so there can be no collisions between paths and storage provider ids in the same map.
{{< /hint >}}


{{< hint warning >}}
### Alternative: reference triple ####
A *reference* is a logical concept. It identifies a [*resource*]({{< ref "#resources" >}}) and consists of
a `storage_space`, a `<root_id>` and a `<path>`
```
<storage_space>!<root_id>:<path>
```
While all components are optional, only three cases are used:
| format | example | description |
|-|-|-|
| `!:<absolute_path>` | `!:/absolute/path/to/file.ext` | absolute path |
| `<storage_space>!:<relative_path>` | `ee1687e5-ac7f-426d-a6c0-03fed91d5f62!:path/to/file.ext` | path relative to the root of the storage space |
| `<storage_space>!<root>:<relative_path>` | `ee1687e5-ac7f-426d-a6c0-03fed91d5f62!c3cf23bb-8f47-4719-a150-1d25a1f6fb56:to/file.ext` | path relative to the specified node in the storage space, used to reference resources without disclosing parent paths |

`<storage_space>` should be a UUID to prevent references from breaking when a *user* or [*storage space*]({{< ref "#storage-spaces" >}}) gets renamed. But it can also be derived from a migration of an oc10 instance by concatenating an instance identifier and the numeric storage id from oc10, e.g. `oc10-instance-a$1234`.

A reference will often start as an absolute/global path, e.g. `!:/home/Projects/Foo`. The gateway will look up the storage provider that is responsible for the path

| Name | Description | Who resolves it? |
|------|-------------|-|
| `!:/home/Projects/Foo` | the absolute path a client like davfs will use. | The gateway uses the storage registry to look up the responsible storage provider |
| `ee1687e5-ac7f-426d-a6c0-03fed91d5f62!:/Projects/Foo` | the `storage_space` is the same as the `root`, the path becomes relative to the root | the storage provider can use this reference to identify this resource |

Now, the same file is accessed as a share
| Name | Description |
|------|-------------|
| `!:/users/Einstein/Projects/Foo` | `Foo` is the shared folder |
| `ee1687e5-ac7f-426d-a6c0-03fed91d5f62!56f7ceca-e7f8-4530-9a7a-fe4b7ec8089a:` | `56f7ceca-e7f8-4530-9a7a-fe4b7ec8089a` is the id of `Foo`, the path is empty |


The `:`, `!` and `$` are chosen from the set of [RFC3986 sub delimiters](https://tools.ietf.org/html/rfc3986#section-2.2) on purpose. They can be used in URLs without having to be encoded. In some cases, a delimiter can be left out if a component is not set:
| reference | interpretation |
|-|-|
| `/absolute/path/to/file.ext` | absolute path, all delimiters omitted |
| `ee1687e5-ac7f-426d-a6c0-03fed91d5f62!path/to/file.ext` | relative path in the given storage space, root delimiter `:` omitted |
| `56f7ceca-e7f8-4530-9a7a-fe4b7ec8089a:to/file.ext` | relative path in the given root node, storage space delimiter `!` omitted |
| `ee1687e5-ac7f-426d-a6c0-03fed91d5f62!56f7ceca-e7f8-4530-9a7a-fe4b7ec8089a:` | node id in the given storage space, `:` must be present |
| `ee1687e5-ac7f-426d-a6c0-03fed91d5f62` | root of the storage space, all delimiters omitted, can be distinguished by the `/` |

{{< /hint >}}

## Storage Drivers

A *storage driver* implements access to a [*storage system*]({{< ref "#storage-systems" >}}):

It maps the *path* and *id* based CS3 *references* to an appropriate [*storage system*]({{< ref "#storage-systems" >}}) specific reference, e.g.:
- eos file ids
- posix inodes or paths
- deconstructed filesystem nodes

{{< hint warning >}}
**Proposed Change**
iOS clients can only queue single requests to be executed in the background. The queue an upload and need to be able to identify the uploaded file after it has been uploaded to the server. The disconnected nature of the connection might cause workflows or manual user interaction with the file on the server to move the file to a different place or changing the content while the device is offline. However, on the device users might have marked the file as favorite or added it to other iOS specific collections. To be able to reliably identify the file the client can generate a `uuid` and attach it to the file metadata during the upload. While it is not necessary to look up files by this `uuid` having a second file id that serves exactly the same purpose as the `file id` is redundant.

Another aspect for the `file id` / `uuid` is that it must be a logical identifier that can be set, at least by internal systems. Without a writeable fileid we cannot restore backups or migrate storage spaces from one storage provider to another storage provider.

Technically, this means that every storage driver needs to have a map of a `uuid` to in internal resource identifier. This internal resource identifier can be
- an eos fileid, because eos can look up files by id
- an inode if the filesystem and the storage driver support looking up by inode
- a path if the storage driver has no way of looking up files by id.
  - In this case other mechanisms like inotify, kernel audit or a fuse overlay might be used to keep the paths up to date.
  - to prevent excessive writes when deep folders are renamed a reverse map might be used: it will map the `uuid` to `<parentuuid>:<childname>`, allowing to trade writes for reads

{{< /hint >}}
## Storage Providers

## Technical concepts

### Storage Systems
{{< svg src="extensions/storage/static/storageprovider.drawio.svg" >}}

{{< hint warning >}}
**Proposed Change**
A *storage provider* manages multiple [*storage spaces*]({{< ref "#storage-space" >}})
by accessing a [*storage system*]({{< ref "#storage-systems" >}}) with a [*storage driver*]({{< ref "#storage-drivers" >}}).

{{< svg src="extensions/storage/static/storageprovider-spaces.drawio.svg" >}}

By making [*storage providers*]({{< ref "#storage-providers" >}}) aware of [*storage spaces*]({{< ref "#storage-spaces" >}}) we can get rid of the current `enablehome` flag / hack in reva, which lead to the [spawn of `*home` drivers](https://github.com/cs3org/reva/tree/master/pkg/storage/fs). Furthermore, provisioning a new [*storage space*]({{< ref "#storage-space" >}}) becomes a generic operation, regardless of the need of provisioning a new user home or a new project space.
{{< /hint >}}

## Storage Space Registries

A *storage registry* manages the [*CS3 global namespace*]({{< ref "./namespaces.md#cs3-global-namespaces" >}}):
It is used by the *gateway*
to look up `address` and `port` of the [*storage provider*]({{< ref "#storage-providers" >}})
that should handle a [*reference*]({{< ref "#references" >}}).

{{< svg src="extensions/storage/static/storageregistry.drawio.svg" >}}

{{< hint warning >}}
**Proposed Change**
A *storage space registry* manages the [*namespace*]({{< ref "./namespaces.md" >}}) for a *user*:
It is used by the *gateway*
to look up `address` and `port` of the [*storage provider*]({{< ref "#storage-providers" >}})
that is currently serving a [*storage space*]({{< ref "#storage-space" >}}).

{{< svg src="extensions/storage/static/storageregistry-spaces.drawio.svg" >}}

By making *storage registries* aware of [*storage spaces*]({{< ref "#storage-spaces" >}}) we can query them for a listing of all [*storage spaces*]({{< ref "#storage-spaces" >}}) a user has access to. Including his home, received shares, project folders or group drives. See [a WIP PR for spaces in the oCIS repo (#1827)](https://github.com/owncloud/ocis/pull/1827) for more info.
{{< /hint >}}

## Storage Spaces
A *storage space* is a logical concept:
It is a tree of [*resources*]({{< ref "#resources" >}})*resources*
with a single *owner* (*user* or *group*),
a *quota* and *permissions*, identified by a `storage space id`.

{{< svg src="extensions/storage/static/storagespace.drawio.svg" >}}

Examples would be every user's home storage space, project storage spaces or group storage spaces. While they all serve different purposes and may or may not have workflows like anti virus scanning enabled, we need a way to identify and manage these subtrees in a generic way. By creating a dedicated concept for them this becomes easier and literally makes the codebase cleaner. A [*storage space registry*]({{< ref "#storage-space-registries" >}}) then allows listing the capabilities of [*storage spaces*]({{< ref "#storage-spaces" >}}), e.g. free space, quota, owner, syncable, root etag, upload workflow steps, ...

Finally, a logical `storage space id` is not tied to a specific [*storage provider*]({{< ref "#storage-providers" >}}). If the [*storage driver*]({{< ref "#storage-drivers" >}}) supports it, we can import existing files including their `file id`, which makes it possible to move [*storage spaces*]({{< ref "#storage-spaces" >}}) between [*storage providers*]({{< ref "#storage-providers" >}}) to implement storage classes, e.g. with or without archival, workflows, on SSDs or HDDs.

## Shares
*To be clarified: we are aware that [*storage spaces*]({{< ref "#storage-spaces" >}}) may be too 'heavyweight' for ad hoc sharing with groups. That being said, there is no technical reason why group shares should not be treated like [*storage spaces*]({{< ref "#storage-spaces" >}}) that users can provision themselves. They would share the quota with the users home [*storage space*]({{< ref "#storage-spaces" >}}) and the share initiator would be the sole owner. Technically, the mechanism of treating a share like a new [*storage space*]({{< ref "#storage-spaces" >}}) would be the same. This obviously also extends to user shares and even file individual shares that would be wrapped in a virtual collection. It would also become possible to share collections of arbitrary files in a single storage space, e.g. the ten best pictures from a large album.*


## Storage Systems
Every *storage system* has different native capabilities like id and path based lookups, recursive change time propagation, permissions, trash, versions, archival and more.
A [*storage provider*]({{< ref "#storage-providers" >}}) makes the storage system available in the CS3 API by wrapping the capabilities as good as possible using a [*storage driver*]({{< ref "./storagedrivers.md" >}}).
There might be multiple [*storage drivers*]({{< ref "./storagedrivers.md" >}}) for a *storage system*, implementing different tradeoffs to match varying requirements.

### Gateways
A *gateway* acts as a facade to the storage related services. It authenticates and forwards API calls that are publicly accessible.

