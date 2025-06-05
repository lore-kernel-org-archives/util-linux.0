Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CF20B7FC
	for <util-linux@vger.kernel.org>; Thu,  5 Jun 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119127; cv=none; b=ZBA1Ms9OxXEh5zOuLRRclze1BrbiVoH1cxZ32AhnKHovpbhTpwz2xbs/UJZD+mVE6OAFjyKK4hWwFP24qhPDILQ5it0LNF8emI5s5qCFrXVNeAjsXUhBz7b+WvDPDP5PQoRjYe0ScC27s9lMKJNfWVFOb+W8XCLxXY7egi27qi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119127; c=relaxed/simple;
	bh=UrrB2Q51EjtXduNbzYNtZcwsF45w5nRoMOKuaeAafHA=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=a0i2kdMwY8GXiVZv7DeWF4bup++EiEpFmw22HARKgx/ftuVYG7GjW/65JFyGW2BCrm9TV1DnM2AuKRkjt1hDGld73zmytx1el2Cwy4sQuGZ5GdEUENhYhBKdxq6ZYZ/+p5cQPT2pINZ9DU61c2plNUyeM7wkT9lkmUKiGg/82nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=s45r7nry; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="s45r7nry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1749119114; x=1749378314;
	bh=UrrB2Q51EjtXduNbzYNtZcwsF45w5nRoMOKuaeAafHA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=s45r7nryjsneGOKca5p76dV/QSliyWG79UMNotsDr2nHkD+5qv2ww4Njz0iMMJrEP
	 d8b4tNIsyo90xKSP/M96Uo2VnGb1FYZpBzWq/NmOtkLIUTa6aO2AWe2RPT7vuW2dDA
	 46rTXxSXSBhGtovOF1iavV/b6g3W2Z3/FhVAL7xkO3f9jU2ywiHIm/aKnNeWurXLMj
	 XtjZ62kEmGV6qC5LCWJm2vJFZoyFhqALK3mGbMY96n8Delzm8JPG74/Dfzd/p/7f3Q
	 /1Vx4tLnCsIPAwmBigdsvWz0N/vzbKHdZgUg5ojJhAthrbIOUTe4kZIaz106TmqWbp
	 AQovcugvZCwjA==
Date: Thu, 05 Jun 2025 10:25:07 +0000
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
From: Nick Piaddo <nick.piaddo@protonmail.com>
Subject: Questions about util-linux
Message-ID: <IM79iX-yrSm2eLiLvGaZqJbIZaqT9SuLnpz0GuSvYOizxuYCJucKrIfwPYCjCos13Y4njHyPz3ftnmz6y5MrsTr6plHxqBIHUDF59iH-GlA=@protonmail.com>
Feedback-ID: 84672370:user:proton
X-Pm-Message-ID: 52e029e3669b61c87e3b865bb337b99f310e102e
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

**As my first post on this mailing list, please advise if "this is NOT the =
way..."**

Hi,

I am developing a personal project in Rust for which I need to probe block
devices, create, and mount partitions; `libblkid`, `libfdisk`, and `libmoun=
t`
fit the bill perfectly.

So, I am writing Rust bindings for `util-linux-2.39` (published on `crates.=
io`):
- `rsblkid`: [crate](https://crates.io/crates/rsblkid) =C2=A0[docs](https:/=
/docs.rs/rsblkid/latest/rsblkid/)
- `rsfdisk`: [crate](https://crates.io/crates/rsfdisk) =C2=A0[docs](https:/=
/docs.rs/rsfdisk/latest/rsfdisk/)
- `rsmount`: [crate](https://crates.io/crates/rsmount) =C2=A0[docs](https:/=
/docs.rs/rsmount/latest/rsmount/)

They are first drafts with APIs that are still in flux, with low test cover=
age,
and some C functions are still missing their Rust equivalents.

Even after going through:
- the source code of each C library,
- their documentation pages,
- the manpages of `blkid`, =C2=A0`fdisk`, `mount`,
- and searching the net for as much information as I could find,

the docs of each crate still reflects my limited knowledge of `util-linux`.

So, I do have a few questions I hope experts on this list may be able to
answer (see further down). **Warning:** It's a long read!

Thank you for your help! (=C2=B4 =CB=98 `=E3=85=85)

Nick

## How are questions structured?

Most questions follow the pattern described below:

```
<id> "-" <question>"?"
<context>
{<url>
<quote>};


<id> =3D <capital-letter><seq-num>;
<capital-letter> =3D "G" | "B" | "F" | "M";
<seq-num> =3D <digit>, {<digit>};
<digit> =3D "0" | "1" | "2" | "3" | "4" | 5 | "6" | 7 | "8" | "9";
```

- `<id>`: unique ID for each question.
- `<question>`: text describing the question.
- `<context>`: text describing the issue that prompted the question.
- `<url>`: link to a source file/documentation page of a function cited in
=C2=A0 `<context>`.
- `<quote>`: excerpt from documentation/source code at `<url>`.

About `<id>`:
-`<capital-letter>`: can be one of
=C2=A0 + `G` for a general question about `util-linux`
=C2=A0 + `B` for a specific question about `libblkid`
=C2=A0 + `F` for a specific question about `libfdisk`
=C2=A0 + `M` for a specific question about `libmount`
- `<seq-num>`: a sequence number.

Please mention the ID of the question you are answering, or are seeking
clarifications for. It will make the conversation easier to follow.

Thanks! (^-^)b

## General questions

G1 - Would it be possible to provide a way to define a destructor for funct=
ions
registering callbacks, long-lived or otherwise?

Interoperating with C, and registering callback functions requires Rust to
allocate state data on the heap.

From the [Rustonomicon](https://doc.rust-lang.org/nomicon/ffi.html#destruct=
ors)
we learn that:
> Foreign libraries often hand off ownership of resources to the calling co=
de.
> When this occurs, we must use Rust's destructors to provide safety and
> guarantee the release of these resources (especially in the case of panic=
).

To free dynamically allocated Rust data, C functions registering callbacks
should have a signature like the one shown below:

```C
void widget_register_callback(
=C2=A0 =C2=A0 widget_t *widget,
=C2=A0 =C2=A0 void *data,
=C2=A0 =C2=A0 void (*callback)(void*, event_t),
=C2=A0 =C2=A0 void (*destroy)(void*)
);
```

See this blog post [Neat Rust Tricks: Passing Rust Closures to
C](http://blog.sagetheprogrammer.com/neat-rust-tricks-passing-rust-closures=
-to-c)
for a presentation of what I dream `util-linux` had. (=E2=95=A5=EF=B9=8F=
=E2=95=A5)=E3=81=A4

While reading `util-linux`'s source code, I identified three types of funct=
ions
to register callbacks:

- functions for which it is essentially impossible to create Rust bindings,
=C2=A0 case in point: `fdisk_table_sort_partitions` (see documentation furt=
her down).
=C2=A0 This function has a signature that looks like the example below.

=C2=A0 ```C
=C2=A0 void widget_register_callback(
=C2=A0 =C2=A0 =C2=A0 widget_t *widget,
=C2=A0 =C2=A0 =C2=A0 void (*callback)(event_t),
=C2=A0 );
=C2=A0 ```

=C2=A0 You will notice that it does not:
=C2=A0 + have a data pointer (`void *data`),
=C2=A0 + provide a callback function that accepts a `void*` parameter,
=C2=A0 + offer a way to set a destructor.

- functions for registering long-lived callbacks with a signature like the =
one
=C2=A0 shown below

=C2=A0 ```C
=C2=A0 void widget_register_callback(
=C2=A0 =C2=A0 =C2=A0 widget_t *widget,
=C2=A0 =C2=A0 =C2=A0 void (*callback)(void*, event_t),
=C2=A0 );
=C2=A0 ```
=C2=A0 For example, `mnt_table_set_parser_errcb` that acts on a `struct
=C2=A0 libmnt_table`. This structure has an internal field to store a data =
pointer,
=C2=A0 along with specialized accessor functions to get/set it (respectivel=
y
=C2=A0 `mnt_table_get_userdata `, and `mnt_table_set_userdata `). However, =
lacking a
=C2=A0 way to define a destructor, this function will leak memory each time=
 it is
=C2=A0 called to replace a callback.

- functions for registering short-lived callbacks with a signature like the=
 one
=C2=A0 shown below

=C2=A0 ```C
=C2=A0 void widget_register_callback(
=C2=A0 =C2=A0 =C2=A0 widget_t *widget,
=C2=A0 =C2=A0 =C2=A0 void *data,
=C2=A0 =C2=A0 =C2=A0 void (*callback)(void*, event_t),
=C2=A0 );
=C2=A0 ```
=C2=A0 For example, `mnt_table_find_next_fs` which is the closest to the id=
eal form.
=C2=A0 Although it lacks a way to define a destructor, being short-lived, i=
t allows
=C2=A0 the enclosing Rust binding to take care of releasing resources alloc=
ated on
=C2=A0 the heap.

https://github.com/util-linux/util-linux/blob/stable/v2.39/libfdisk/src/fdi=
skP.h#L200-L205

```C
struct fdisk_table {
struct list_head parts; /* partitions */
int refcount;
size_t nents; /* number of partitions */
};

```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libfdisk-d=
ocs/libfdisk-Table.html#fdisk-table-sort-partitions

```text
int
fdisk_table_sort_partitions (struct fdisk_table *tb,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*cmp) (struct fdisk_partition *, str=
uct fdisk_partition *));

Sort partition in the table.

Parameters

tb table

cmp compare function

Returns

0 on success, <0 on error.
```

https://github.com/util-linux/util-linux/blob/stable/v2.39/libmount/src/mou=
ntP.h#L249-L273

```C
/*
=C2=A0* fstab/mountinfo file
=C2=A0*/
struct libmnt_table {
int fmt; /* MNT_FMT_* file format */
int nents; /* number of entries */
int refcount; /* reference counter */
int comms; /* enable/disable comment parsing */
char *comm_intro; /* First comment in file */
char *comm_tail; /* Last comment in file */


struct libmnt_cache *cache; /* canonicalized paths/tags cache */


=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*errcb)(struct libmnt_table *tb,
const char *filename, int line);


int (*fltrcb)(struct libmnt_fs *fs, void *data);
void *fltrcb_data;


int noautofs; /* ignore autofs mounts */


struct list_head ents; /* list of entries (libmnt_fs) */
void *userdata;
};
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Table-of-filesystems.html#mnt-table-set-parser-errcb

```text
int
mnt_table_set_parser_errcb (struct libmnt_table *tb,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*cb) (struct libmnt_table *tb, const char =
*filename, int line));

The error callback function is called by table parser (mnt_table_parse_file=
())
in case of a syntax error. The callback function could be used for error
evaluation, libmount will continue/stop parsing according to callback retur=
n
codes:

<0 : fatal error (abort parsing) 0 : success (parsing continues) >0 :
recoverable error (the line is ignored, parsing continues).

Parameters

tb pointer to table

cb pointer to callback function

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Table-of-filesystems.html#mnt-table-get-userdata

```text
void *
mnt_table_get_userdata (struct libmnt_table *tb);

Parameters

tb pointer to tab

Returns

pointer to user's data.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Table-of-filesystems.html#mnt-table-set-userdata

```text
int
mnt_table_set_userdata (struct libmnt_table *tb,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 void *data);

Sets pointer to the private user data.
Parameters

tb pointer to tab


data pointer to user data

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Table-of-filesystems.html#mnt-table-find-next-fs

```text
int
mnt_table_find_next_fs (struct libmnt_table *tb,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct libmnt_iter *itr,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int (*match_func) (struct libmnt_fs *, void *),
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 void *userdata,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct libmnt_fs **fs);

This function allows searching in tb .

Parameters

tb table

itr iterator

match_func function returning 1 or 0

userdata extra data for match_func

fs NULL or returns pointer to the next matching table entry

Returns

negative number in case of error, 1 at end of table or 0 o success.
```

G2 - How can I create device images that will trigger errors when running
unit-tests?

For example, files in `util-linux/tests/expected/blkid` show the expected
outputs after probing the properties of device images in
`util-linux/tests/ts/blkid/images-fs`.

Each image in the directory has a well-formed partition table, so tests wil=
l
always walk the "happy path". There is no image that could, for example,
trigger a collision error between probing results.

Rust provides its own test framework, with which it is easy to check functi=
ons
(including error cases) at a more granular level than with the test suite i=
n
`util-linux`.

Knowing how to create an intentionally broken device image would be wonderf=
ul.
It would allow me to increase test coverage of my Rust-bindings.

## libblkid

B1 - Are there public accessor functions on the roadmap of `libblkid` for
reading the private fields `bid_pri`, `bid_devno`, and `bid_time` in
`blkid_dev_struct`?

For the moment, I can not accurately reproduce the way data about a
`blkid_struct_dev` is printed in `/run/blkid/blkid.tab` due to not being ab=
le
to access the relevant fields.

Example of a line in `/run/blkid/blkid.tab`

```text
<device DEVNO=3D"0xfe01" TIME=3D"1687337407.788618" PRI=3D"45" LABEL=3D"roo=
t" UUID=3D"9e4adae9-4122-47fe-848f-67a9eb726207" BLOCK_SIZE=3D"4096" TYPE=
=3D"ext4">/dev/mapper/vg_nixos-root</device>
```

What I can currently output from Rust

```text
<device LABEL=3D"root" UUID=3D"9e4adae9-4122-47fe-848f-67a9eb726207" BLOCK_=
SIZE=3D"4096" TYPE=3D"ext4">/dev/mapper/vg_nixos-root</device>
```

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libblkid/src/blkidP.h#L45-L61

```C
struct blkid_struct_dev
{
struct list_head bid_devs; /* All devices in the cache */
struct list_head bid_tags; /* All tags for this device */
blkid_cache bid_cache; /* Dev belongs to this cache */
char *bid_name; /* Device real path (as used in cache) */
char *bid_xname; /* Device path as used by application (maybe symlink..) */
char *bid_type; /* Preferred device TYPE */
int bid_pri; /* Device priority */
dev_t bid_devno; /* Device major/minor number */
time_t bid_time; /* Last update time of device */
suseconds_t bid_utime; /* Last update time (microseconds) */
unsigned int bid_flags; /* Device status bitflags */
char *bid_label; /* Shortcut to device LABEL */
char *bid_uuid; /* Shortcut to binary UUID */
};
```


B2 - Does anyone know what the function `blkid_dev_set_search` is supposed =
to
do?

There are no docstrings for this function. Although I read its source code,=
 I
could not figure out its purpose. =C2=A0<('^-^)

https://github.com/util-linux/util-linux/blob/stable/v2.39/libblkid/src/dev=
.c#L150-L172

```C
int blkid_dev_set_search(blkid_dev_iterate iter,
const char *search_type, const char *search_value)
{
char *new_type, *new_value;


if (!iter || iter->magic !=3D DEV_ITERATE_MAGIC || !search_type ||
=C2=A0 =C2=A0!search_value)
return -1;
new_type =3D malloc(strlen(search_type)+1);
new_value =3D malloc(strlen(search_value)+1);
if (!new_type || !new_value) {
free(new_type);
free(new_value);
return -1;
}
strcpy(new_type, search_type);
strcpy(new_value, search_value);
free(iter->search_type);
free(iter->search_value);
iter->search_type =3D new_type;
iter->search_value =3D new_value;
return 0;
}
```


B3 - =C2=A0Do I define `size` as `uint64_t` or `int64_t`?

The `size` field in `struct blkid_struct_probe` is of type `uint64_t`. But,
according to the documentation, its accessor function `blkid_probe_get_sect=
ors`
may return `-1` in case of error.

Reading the code of `blkid_probe_get_sectors`, I can see that it just divid=
es
`size` by 512 which would never return a negative value (see below).

https://github.com/util-linux/util-linux/blob/stable/v2.39/libblkid/src/blk=
idP.h#L203-L233

```C
/*
=C2=A0* Low-level probing control struct
=C2=A0*/
struct blkid_struct_probe
{
int fd; /* device file descriptor */
uint64_t off; /* begin of data on the device */
uint64_t size; /* end of data on the device */

dev_t devno; /* device number (st.st_rdev) */
dev_t disk_devno; /* devno of the whole-disk or 0 */
unsigned int blkssz; /* sector size (BLKSSZGET ioctl) */
mode_t mode; /* struct stat.sb_mode */
uint64_t zone_size; /* zone size (BLKGETZONESZ ioctl) */

int flags; /* private library flags */
int prob_flags; /* always zeroized by blkid_do_*() */

uint64_t wipe_off; /* begin of the wiped area */
uint64_t wipe_size; /* size of the wiped area */
struct blkid_chain *wipe_chain; /* superblock, partition, ... */

struct list_head buffers; /* list of buffers */
struct list_head hints;

struct blkid_chain chains[BLKID_NCHAINS]; /* array of chains */
struct blkid_chain *cur_chain; /* current chain */

struct list_head values; /* results */

struct blkid_struct_probe *parent; /* for clones */
struct blkid_struct_probe *disk_probe; /* whole-disk probing */
};

```

https://github.com/util-linux/util-linux/blob/stable/v2.39/libblkid/src/blk=
id.h.in#L85-L90

```C
/**
=C2=A0* blkid_loff_t:
=C2=A0*
=C2=A0* 64-bit signed number for offsets and sizes
=C2=A0*/
typedef int64_t blkid_loff_t;
```

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libblkid/src/probe.c#L1971-L1983

```C
/**
=C2=A0* blkid_probe_get_sectors:
=C2=A0* @pr: probe
=C2=A0*
=C2=A0* Returns: 512-byte sector count or -1 in case of error.
=C2=A0*/
blkid_loff_t blkid_probe_get_sectors(blkid_probe pr)
{
return (blkid_loff_t) (pr->size >> 9);
}
```


B4 - Is the documentation out-of-date or just anticipating a future change?

The function `blkid_probe_set_sectorsize` always returns `0`, but its docst=
ring
says otherwise.

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libblkid/src/probe.c#L2014-L2030

```C
/**
=C2=A0* blkid_probe_set_sectorsize:
=C2=A0* @pr: probe
=C2=A0* @sz: new size (to overwrite system default)
=C2=A0*
=C2=A0* Note that blkid_probe_set_device() resets this setting. Use it afte=
r
=C2=A0* blkid_probe_set_device() and before any probing call.
=C2=A0*
=C2=A0* Since: 2.30
=C2=A0*
=C2=A0* Returns: 0 or <0 in case of error
=C2=A0*/
int blkid_probe_set_sectorsize(blkid_probe pr, unsigned int sz)
{
pr->blkssz =3D sz;
return 0;
}
```


B5 - Is there a list of all file systems supported by `libblkid`?

By searching the source code, I managed to constitute a list of supported f=
ile
systems gathered in the enum
[`FileSystem`](https://docs.rs/rsblkid/latest/rsblkid/partition/enum.FileSy=
stem.html#variants)
in `rsblkid`.

It would be nice if I could double-check its accuracy from an official
reference.


B6 - Is there a list of all tags supported by `libblkid`?

By searching the source code, I managed to constitute a list of supported t=
ags
gathered in the enum
[`Tag`](https://docs.rs/rsblkid/latest/rsblkid/device/enum.Tag.html#variant=
s)
in `rsblkid`.

It would be nice if I could double-check its accuracy from an official
reference.

## libfdisk

F1 - What is a `grain size`?

The documentation of `fdisk_get_grain_size` says "grain in bytes used to al=
ign
partitions (usually 1MiB)" but does not elaborate.

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libfdisk-d=
ocs/libfdisk-Context.html#fdisk-get-grain-size

I stumbled on this answer about partition alignment during my search:

"What is partition alignment and why whould I need it?"

https://superuser.com/a/393918

Is it what `fdisk_get_grain_size` is refering to?


F2 - Are `fdisk_labelitem_*` supposed to have globally unique values, or is=
 the
overlap intentional?

The way they are currently defined `SUN_LABELITEM_LABELID`,
`BSD_LABELITEM_TYPE`,`SGI_LABELITEM_PCYLCOUNT` , and `GPT_LABELITEM_FIRSTLB=
A`
end up having the same numerical value i.e. =C2=A0`__FDISK_NLABELITEMS =3D =
8`.

As I understand it, these LABELITEM are fields in a partition table header =
for
their respective partition table types.

To represent them in Rust, I use
[HeaderEntry](https://docs.rs/rsfdisk/latest/rsfdisk/partition_table/enum.H=
eaderEntry.html#)
which groups the LABELITEMs in a unified enum.

This enum uses a workaround to convert a `HeaderEntry` to the native `u32`
value used by `libfdisk`
https://github.com/nickpiaddo/rsfdisk/blob/main/src/core/partition_table/he=
ader_entry_enum.rs

But converting back from `u32` to `HeaderEntry` is all but impossible if th=
e
value of each `fdisk_labelitem_*` is not globally unique.

See their definitions below.

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libfdisk/src/libfdisk.h.in#L414-L425

```C
=C2=A0 /**
=C2=A0 =C2=A0* fdisk_labelitem_gen:
=C2=A0 =C2=A0* @FDISK_LABELITEM_ID: Unique disk identifier
=C2=A0 =C2=A0* @__FDISK_NLABELITEMS: Specifies reserved range for generic i=
tems (0..7)
=C2=A0 =C2=A0*
=C2=A0 =C2=A0* Generic disklabel items.
=C2=A0 =C2=A0*/
=C2=A0 enum fdisk_labelitem_gen {
=C2=A0 =C2=A0 FDISK_LABELITEM_ID =3D 0,
=C2=A0 =C2=A0 __FDISK_NLABELITEMS =3D 8
=C2=A0 };
```

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libfdisk/src/libfdisk.h.in#L634-L655

```C
=C2=A0 =C2=A0 /**
=C2=A0 =C2=A0* fdisk_labelitem_sun:
=C2=A0 =C2=A0* @SUN_LABELITEM_LABELID: Label ID
=C2=A0 =C2=A0* @SUN_LABELITEM_VTOCID: Volume ID
=C2=A0 =C2=A0* @SUN_LABELITEM_RPM: Rpm
=C2=A0 =C2=A0* @SUN_LABELITEM_ACYL: Alternate cylinders
=C2=A0 =C2=A0* @SUN_LABELITEM_PCYL: Physical cylinders
=C2=A0 =C2=A0* @SUN_LABELITEM_APC: Extra sects/cyl
=C2=A0 =C2=A0* @SUN_LABELITEM_INTRLV: Interleave
=C2=A0 =C2=A0*
=C2=A0 =C2=A0* SUN specific label items.
=C2=A0 =C2=A0*/
=C2=A0 enum fdisk_labelitem_sun {
=C2=A0 =C2=A0 SUN_LABELITEM_LABELID =3D __FDISK_NLABELITEMS,
=C2=A0 =C2=A0 SUN_LABELITEM_VTOCID,
=C2=A0 =C2=A0 SUN_LABELITEM_RPM,
=C2=A0 =C2=A0 SUN_LABELITEM_ACYL,
=C2=A0 =C2=A0 SUN_LABELITEM_PCYL,
=C2=A0 =C2=A0 SUN_LABELITEM_APC,
=C2=A0 =C2=A0 SUN_LABELITEM_INTRLV
=C2=A0 };

```

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libfdisk/src/libfdisk.h.in#L661-L697

```C
=C2=A0 =C2=A0 /**
=C2=A0 =C2=A0* fdisk_labelitem_bsd:
=C2=A0 =C2=A0* @BSD_LABELITEM_TYPE: type
=C2=A0 =C2=A0* @BSD_LABELITEM_DISK: disk
=C2=A0 =C2=A0* @BSD_LABELITEM_PACKNAME: packname
=C2=A0 =C2=A0* @BSD_LABELITEM_FLAGS: flags (removable, ecc, badsect)
=C2=A0 =C2=A0* @BSD_LABELITEM_SECSIZE: Bytes/Sector
=C2=A0 =C2=A0* @BSD_LABELITEM_NTRACKS: Tracks/Cylinder
=C2=A0 =C2=A0* @BSD_LABELITEM_SECPERCYL: Sectors/Cylinder
=C2=A0 =C2=A0* @BSD_LABELITEM_CYLINDERS: Cylinders
=C2=A0 =C2=A0* @BSD_LABELITEM_RPM: rpm
=C2=A0 =C2=A0* @BSD_LABELITEM_INTERLEAVE: interleave
=C2=A0 =C2=A0* @BSD_LABELITEM_TRACKSKEW: trackskew
=C2=A0 =C2=A0* @BSD_LABELITEM_CYLINDERSKEW: cylinderskew
=C2=A0 =C2=A0* @BSD_LABELITEM_HEADSWITCH: headswitch
=C2=A0 =C2=A0* @BSD_LABELITEM_TRKSEEK: track-to-track seek
=C2=A0 =C2=A0*
=C2=A0 =C2=A0* BSD specific label items.
=C2=A0 =C2=A0*/
=C2=A0 enum fdisk_labelitem_bsd {
=C2=A0 =C2=A0 /* specific */
=C2=A0 =C2=A0 BSD_LABELITEM_TYPE =3D __FDISK_NLABELITEMS,
=C2=A0 =C2=A0 BSD_LABELITEM_DISK,
=C2=A0 =C2=A0 BSD_LABELITEM_PACKNAME,
=C2=A0 =C2=A0 BSD_LABELITEM_FLAGS,
=C2=A0 =C2=A0 BSD_LABELITEM_SECSIZE,
=C2=A0 =C2=A0 BSD_LABELITEM_NTRACKS,
=C2=A0 =C2=A0 BSD_LABELITEM_SECPERCYL,
=C2=A0 =C2=A0 BSD_LABELITEM_CYLINDERS,
=C2=A0 =C2=A0 BSD_LABELITEM_RPM,
=C2=A0 =C2=A0 BSD_LABELITEM_INTERLEAVE,
=C2=A0 =C2=A0 BSD_LABELITEM_TRACKSKEW,
=C2=A0 =C2=A0 BSD_LABELITEM_CYLINDERSKEW,
=C2=A0 =C2=A0 BSD_LABELITEM_HEADSWITCH,
=C2=A0 =C2=A0 BSD_LABELITEM_TRKSEEK
=C2=A0 };

```

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libfdisk/src/libfdisk.h.in#L704-L719

```C
=C2=A0 =C2=A0 /**
=C2=A0 =C2=A0* fdisk_labelitem_sgi:
=C2=A0 =C2=A0* @SGI_LABELITEM_PCYLCOUNT: Physical cylinders
=C2=A0 =C2=A0* @SGI_LABELITEM_SPARECYL: Extra sects/cyl
=C2=A0 =C2=A0* @SGI_LABELITEM_ILFACT: nterleave
=C2=A0 =C2=A0* @SGI_LABELITEM_BOOTFILE: Bootfile
=C2=A0 =C2=A0*
=C2=A0 =C2=A0* SGI specific label items.
=C2=A0 =C2=A0*/
=C2=A0 enum fdisk_labelitem_sgi {
=C2=A0 =C2=A0 SGI_LABELITEM_PCYLCOUNT =3D __FDISK_NLABELITEMS,
=C2=A0 =C2=A0 SGI_LABELITEM_SPARECYL,
=C2=A0 =C2=A0 SGI_LABELITEM_ILFACT,
=C2=A0 =C2=A0 SGI_LABELITEM_BOOTFILE
=C2=A0 };

```

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libfdisk/src/libfdisk.h.in#L775-L798

```C
=C2=A0 =C2=A0 /**
=C2=A0 =C2=A0* fdisk_labelitem_gpt:
=C2=A0 =C2=A0* @GPT_LABELITEM_ID: GPT disklabel UUID (!=3D partition UUID)
=C2=A0 =C2=A0* @GPT_LABELITEM_FIRSTLBA: First Usable LBA
=C2=A0 =C2=A0* @GPT_LABELITEM_LASTLBA: Last Usable LBA
=C2=A0 =C2=A0* @GPT_LABELITEM_ALTLBA: Alternative LBA (backup header LBA)
=C2=A0 =C2=A0* @GPT_LABELITEM_ENTRIESLBA: Partitions entries array LBA
=C2=A0 =C2=A0* @GPT_LABELITEM_ENTRIESALLOC: Number of allocated entries in =
entries array
=C2=A0 =C2=A0* @GPT_LABELITEM_ENTRIESLASTLBA: Last LBA where is entries arr=
ay
=C2=A0 =C2=A0*
=C2=A0 =C2=A0* GPT specific label items.
=C2=A0 =C2=A0*/
=C2=A0 enum fdisk_labelitem_gpt {
=C2=A0 =C2=A0 /* generic */
=C2=A0 =C2=A0 GPT_LABELITEM_ID =3D FDISK_LABELITEM_ID,
=C2=A0 =C2=A0 /* specific */
=C2=A0 =C2=A0 GPT_LABELITEM_FIRSTLBA =3D __FDISK_NLABELITEMS,
=C2=A0 =C2=A0 GPT_LABELITEM_LASTLBA,
=C2=A0 =C2=A0 GPT_LABELITEM_ALTLBA,
=C2=A0 =C2=A0 GPT_LABELITEM_ENTRIESLBA,
=C2=A0 =C2=A0 GPT_LABELITEM_ENTRIESALLOC,
=C2=A0 =C2=A0 GPT_LABELITEM_ENTRIESLASTLBA
=C2=A0 };

```


F3 - In the function `fdisk_locate_disklabel`, in what unit are `offset`, a=
nd
`size` expressed? bytes? sectors?

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libfdisk-d=
ocs/libfdisk-Label.html#fdisk-locate-disklabel

```text
=C2=A0 int
=C2=A0 fdisk_locate_disklabel (struct fdisk_context *cxt,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int n,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const char **name,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 uint64_t *offset,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 size_t *size);

=C2=A0 Locate disklabel and returns info about n item of the label.

=C2=A0 For example GPT is composed from three items, PMBR and GPT, n=3D0 re=
turn offset
=C2=A0 to PMBR and n=3D1 return offset to GPT Header and n=3D2 returns offs=
et to GPT array
=C2=A0 of partitions, n=3D3 and n=3D4 returns location of the backup GPT la=
bel at the end
=C2=A0 of the disk.

=C2=A0 The function returns the current in-memory situation. It's possible =
that a
=C2=A0 header location is modified by write operation, for example when ena=
bled
=C2=A0 minimization (see fdisk_gpt_enable_minimize()). In this case it's be=
tter to
=C2=A0 call this function after fdisk_write_disklabel().

=C2=A0 For more details see 'D' expert fdisk command.

=C2=A0 Parameters

=C2=A0 =C2=A0 cxt context

=C2=A0 =C2=A0 n N item

=C2=A0 =C2=A0 name return item name

=C2=A0 =C2=A0 offset return offset where is item

=C2=A0 =C2=A0 size of the item

=C2=A0 Returns

=C2=A0 =C2=A0 0 on success, <0 on error, 1 no more items.

```

## libmount

M1 - Does `libmount` plan to provide public functions to access/set the
private `fmt` field in `struct libmnt_table`?

From what I understand, `struct libmnt_table` is a generic data type used t=
o
represent either of the following files:
- `/etc/fstab`
- `/proc/#/mountinfo`
- `/run/mount/utab`
- `/proc/swaps`

The `fmt` field helps distinguish each subtype, and being able to set it wo=
uld
make it easier for me to instantiate the appropriate type Rust-side (i.e.
`FsTab`, `MountInfo`, `UTab`, `Swaps`).

https://github.com/util-linux/util-linux/blob/stable/v2.39/libmount/src/mou=
ntP.h#L252-L287

```C
/*
=C2=A0* fstab/mountinfo file
=C2=A0*/
struct libmnt_table {
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 fmt; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MNT_FMT_=
* file format */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 nents; =C2=A0 =C2=A0 =C2=A0/* number of ent=
ries */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 refcount; =C2=A0 /* reference counter */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 comms; =C2=A0 =C2=A0 =C2=A0/* enable/disabl=
e comment parsing */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*comm_intro; =C2=A0 =C2=A0/* =
First comment in file */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*comm_tail; /* Last comment i=
n file */

=C2=A0 =C2=A0 struct libmnt_cache *cache; =C2=A0 =C2=A0 /* canonicalized pa=
ths/tags cache */

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 (*errcb)(struct libmnt_table *tb,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename, int l=
ine);

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 (*fltrcb)(struct libmnt_fs *fs, void *data)=
;
=C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0*fltrcb_data;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 noautofs; =C2=A0 /* ignore autofs mounts */

=C2=A0 =C2=A0 struct list_head =C2=A0 =C2=A0ents; =C2=A0 /* list of entries=
 (libmnt_fs) */
=C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0*userdata;
};

/*
=C2=A0* Tab file format
=C2=A0*/
enum {
=C2=A0 =C2=A0 MNT_FMT_GUESS,
=C2=A0 =C2=A0 MNT_FMT_FSTAB, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* /etc/{fs,=
m}tab */
=C2=A0 =C2=A0 MNT_FMT_MTAB =3D MNT_FMT_FSTAB, =C2=A0 /* alias */
=C2=A0 =C2=A0 MNT_FMT_MOUNTINFO, =C2=A0 =C2=A0 =C2=A0/* /proc/#/mountinfo *=
/
=C2=A0 =C2=A0 MNT_FMT_UTAB, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* /run/moun=
t/utab */
=C2=A0 =C2=A0 MNT_FMT_SWAPS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* /proc/swa=
ps */
};
```


M2 - If we were to split `struct libmnt_fs` into one type per file format,
would we get data types resembling `struct entry_fstab`, `struct
entry_mountinfo`, `struct entry_utab`, `struct_swaps` described below?

As far as I can tell, `struct libmnt_fs` is a multi-purpose data type
representing a line in either of the following files:
- `/etc/fstab`
- `/proc/#/mountinfo`
- `/run/mount/utab`
- `/proc/swaps`

Each file has a distinct format. So, some fields present in `struct libmnt_=
fs`
do not apply to certain files.

https://github.com/util-linux/util-linux/blob/stable/v2.39/libmount/src/mou=
ntP.h#L188-L239

```C
/*
=C2=A0* This struct represents one entry in a fstab/mountinfo file.
=C2=A0* (note that fstab[1] means the first column from fstab, and so on...=
)
=C2=A0*/
struct libmnt_fs {
=C2=A0 =C2=A0 struct list_head ents;
=C2=A0 =C2=A0 struct libmnt_table *tab;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 refcount; =C2=A0 /* reference counter */

=C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0opts_age; =C2=A0 /* to sync with op=
tlist */
=C2=A0 =C2=A0 struct libmnt_optlist *optlist;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 id; =C2=A0 =C2=A0 /* mountinfo[1]: ID */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 parent; =C2=A0 =C2=A0 /* mountinfo[2]: pare=
nt */
=C2=A0 =C2=A0 dev_t =C2=A0 =C2=A0 =C2=A0 devno; =C2=A0 =C2=A0 =C2=A0/* moun=
tinfo[3]: st_dev */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*bindsrc; =C2=A0 /* utab, ful=
l path from fstab[1] for bind mounts */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*source; =C2=A0 =C2=A0/* fsta=
b[1], mountinfo[10], swaps[1]:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* source dev, file, dir or TAG */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*tagname; =C2=A0 /* fstab[1]:=
 tag name - "LABEL", "UUID", ..*/
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*tagval; =C2=A0 =C2=A0/* =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag value */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*root; =C2=A0 =C2=A0 =C2=
=A0/* mountinfo[4]: root of the mount within the FS */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*target; =C2=A0 =C2=A0/* moun=
tinfo[5], fstab[2]: mountpoint */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*fstype; =C2=A0 =C2=A0/* moun=
tinfo[9], fstab[3]: filesystem type */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*optstr; =C2=A0 =C2=A0/* fsta=
b[4], merged options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*vfs_optstr; =C2=A0 =C2=A0/* =
mountinfo[6]: fs-independent (VFS) options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*opt_fields; =C2=A0 =C2=A0/* =
mountinfo[7]: optional fields */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*fs_optstr; /* mountinfo[11]:=
 fs-dependent options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*user_optstr; =C2=A0 /* users=
pace mount options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*attrs; =C2=A0 =C2=A0 /* moun=
t attributes */

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 freq; =C2=A0 =C2=A0 =C2=A0 /* fstab[5]: dum=
p frequency in days */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 passno; =C2=A0 =C2=A0 /* fstab[6]: pass num=
ber on parallel fsck */

=C2=A0 =C2=A0 /* /proc/swaps */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*swaptype; =C2=A0/* swaps[2]:=
 device type (partition, file, ...) */
=C2=A0 =C2=A0 off_t =C2=A0 =C2=A0 =C2=A0 size; =C2=A0 =C2=A0 =C2=A0 /* swap=
s[3]: swaparea size */
=C2=A0 =C2=A0 off_t =C2=A0 =C2=A0 =C2=A0 usedsize; =C2=A0 /* swaps[4]: used=
 size */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 priority; =C2=A0 /* swaps[5]: swap priority=
 */

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 flags; =C2=A0 =C2=A0 =C2=A0/* MNT_FS_* flag=
s */
=C2=A0 =C2=A0 pid_t =C2=A0 =C2=A0 =C2=A0 tid; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* /proc/<tid>/mountinfo otherwise zero */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*comment; =C2=A0 /* fstab com=
ment */

=C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0*userdata; =C2=A0/* library i=
ndependent data */
};

```

### `/etc/fstab`

```C
struct entry_fstab {
=C2=A0 =C2=A0 struct list_head ents;
=C2=A0 =C2=A0 struct libmnt_table *tab;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 refcount; =C2=A0 /* reference counter */

=C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0opts_age; =C2=A0 /* to sync with op=
tlist */
=C2=A0 =C2=A0 struct libmnt_optlist *optlist;


=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*bindsrc; =C2=A0 /* utab, ful=
l path from fstab[1] for bind mounts */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*source; =C2=A0 =C2=A0/* fsta=
b[1], mountinfo[10], swaps[1]:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* source dev, file, dir or TAG */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*tagname; =C2=A0 /* fstab[1]:=
 tag name - "LABEL", "UUID", ..*/
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*tagval; =C2=A0 =C2=A0/* =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag value */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*target; =C2=A0 =C2=A0/* moun=
tinfo[5], fstab[2]: mountpoint */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*fstype; =C2=A0 =C2=A0/* moun=
tinfo[9], fstab[3]: filesystem type */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*optstr; =C2=A0 =C2=A0/* fsta=
b[4], merged options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*user_optstr; =C2=A0 /* users=
pace mount options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*attrs; =C2=A0 =C2=A0 /* moun=
t attributes */

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 freq; =C2=A0 =C2=A0 =C2=A0 /* fstab[5]: dum=
p frequency in days */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 passno; =C2=A0 =C2=A0 /* fstab[6]: pass num=
ber on parallel fsck */


=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*comment; =C2=A0 /* fstab com=
ment */

=C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0*userdata; =C2=A0/* library i=
ndependent data */
};
```

### `/proc/#/mountinfo`

```C
struct entry_mountinfo {
=C2=A0 =C2=A0 struct list_head ents;
=C2=A0 =C2=A0 struct libmnt_table *tab;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 refcount; =C2=A0 /* reference counter */

=C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0opts_age; =C2=A0 /* to sync with op=
tlist */
=C2=A0 =C2=A0 struct libmnt_optlist *optlist;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 id; =C2=A0 =C2=A0 /* mountinfo[1]: ID */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 parent; =C2=A0 =C2=A0 /* mountinfo[2]: pare=
nt */
=C2=A0 =C2=A0 dev_t =C2=A0 =C2=A0 =C2=A0 devno; =C2=A0 =C2=A0 =C2=A0/* moun=
tinfo[3]: st_dev */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*source; =C2=A0 =C2=A0/* fsta=
b[1], mountinfo[10], swaps[1]:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* source dev, file, dir or TAG */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*root; =C2=A0 =C2=A0 =C2=
=A0/* mountinfo[4]: root of the mount within the FS */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*target; =C2=A0 =C2=A0/* moun=
tinfo[5], fstab[2]: mountpoint */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*fstype; =C2=A0 =C2=A0/* moun=
tinfo[9], fstab[3]: filesystem type */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*vfs_optstr; =C2=A0 =C2=A0/* =
mountinfo[6]: fs-independent (VFS) options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*opt_fields; =C2=A0 =C2=A0/* =
mountinfo[7]: optional fields */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*fs_optstr; /* mountinfo[11]:=
 fs-dependent options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*user_optstr; =C2=A0 /* users=
pace mount options */

=C2=A0 =C2=A0 pid_t =C2=A0 =C2=A0 =C2=A0 tid; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* /proc/<tid>/mountinfo otherwise zero */
};
```

### `/run/mount/utab`

```C
struct entry_utab {
=C2=A0 =C2=A0 struct list_head ents;
=C2=A0 =C2=A0 struct libmnt_table *tab;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 refcount; =C2=A0 /* reference counter */

=C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0opts_age; =C2=A0 /* to sync with op=
tlist */
=C2=A0 =C2=A0 struct libmnt_optlist *optlist;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 id; =C2=A0 =C2=A0 /* mountinfo[1]: ID */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 parent; =C2=A0 =C2=A0 /* mountinfo[2]: pare=
nt */
=C2=A0 =C2=A0 dev_t =C2=A0 =C2=A0 =C2=A0 devno; =C2=A0 =C2=A0 =C2=A0/* moun=
tinfo[3]: st_dev */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*bindsrc; =C2=A0 /* utab, ful=
l path from fstab[1] for bind mounts */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*source; =C2=A0 =C2=A0/* fsta=
b[1], mountinfo[10], swaps[1]:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* source dev, file, dir or TAG */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*root; =C2=A0 =C2=A0 =C2=
=A0/* mountinfo[4]: root of the mount within the FS */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*target; =C2=A0 =C2=A0/* moun=
tinfo[5], fstab[2]: mountpoint */

=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*user_optstr; =C2=A0 /* users=
pace mount options */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*attrs; =C2=A0 =C2=A0 /* moun=
t attributes */

=C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0*userdata; =C2=A0/* library i=
ndependent data */
};
```

### `/proc/swaps`

```C
struct entry_swaps {
=C2=A0 =C2=A0 struct list_head ents;
=C2=A0 =C2=A0 struct libmnt_table *tab;

=C2=A0 =C2=A0 int =C2=A0 =C2=A0 refcount; =C2=A0 /* reference counter */

=C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0opts_age; =C2=A0 /* to sync with op=
tlist */
=C2=A0 =C2=A0 struct libmnt_optlist *optlist;


=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*source; =C2=A0 =C2=A0/* fsta=
b[1], mountinfo[10], swaps[1]:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* source dev, file, dir or TAG */

=C2=A0 =C2=A0 /* /proc/swaps */
=C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0*swaptype; =C2=A0/* swaps[2]:=
 device type (partition, file, ...) */
=C2=A0 =C2=A0 off_t =C2=A0 =C2=A0 =C2=A0 size; =C2=A0 =C2=A0 =C2=A0 /* swap=
s[3]: swaparea size */
=C2=A0 =C2=A0 off_t =C2=A0 =C2=A0 =C2=A0 usedsize; =C2=A0 /* swaps[4]: used=
 size */
=C2=A0 =C2=A0 int =C2=A0 =C2=A0 priority; =C2=A0 /* swaps[5]: swap priority=
 */

};
```


M3 - About `struct libmnt_fs` mentioned in question `M2`, is the following =
a
good partition of which subsets of functions, acting on the struct, are
specific/exclusive to each type of file entry? =C2=A0(We assume that items =
not in
a union of the subsets below are shared between line types)

### Functions specific/exclusive to `/etc/fstab`

- `mnt_fs_append_comment`
- `mnt_fs_append_options `
- `mnt_fs_get_comment `
- `mnt_fs_get_freq `
- `mnt_fs_get_fstype `
- `mnt_fs_get_option `
- `mnt_fs_get_options `
- `mnt_fs_get_passno `
- `mnt_fs_get_source `
- `mnt_fs_get_tag `
- `mnt_fs_get_target `
- `mnt_fs_match_fstype `
- `mnt_fs_match_options `
- `mnt_fs_match_target `
- `mnt_fs_prepend_options `
- `mnt_fs_print_debug `
- `mnt_fs_set_comment `
- `mnt_fs_set_freq `
- `mnt_fs_set_fstype `
- `mnt_fs_set_options `
- `mnt_fs_set_passno `
- `mnt_fs_set_source `
- `mnt_fs_set_target `
- `mnt_fs_streq_target `
- `mnt_fs_to_mntent `
- `mnt_new_fs `

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-append-comment

```text
int
mnt_fs_append_comment (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const char *comm);

See also mnt_fs_set_comment().
Parameters

fs fstab entry pointer

comm comment string

Returns

0 on success or <0 in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-append-options

```text
int
mnt_fs_append_options (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const char *optstr);

Parses (splits) optstr and appends results to VFS, FS and userspace lists o=
f options.

If optstr is NULL, then fs is not modified and 0 is returned.
Parameters

fs fstab/mtab/mountinfo entry

optstr mount options

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-comment

```text
const char *
mnt_fs_get_comment (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

0 on success, 1 when not found the name or negative number in case of error=
.

```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-freq

```text
int
mnt_fs_get_freq (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

dump frequency in days.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-fstype

```text
const char *
mnt_fs_get_fstype (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

pointer to filesystem type.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-option

```text
int
mnt_fs_get_option (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const =
char *name,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *=
*value,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t=
 *valsz);

Parameters

fs fstab/mtab/mountinfo entry pointer

name option name

value returns pointer to the beginning of the value (e.g. name=3DVALUE) or =
NULL

valsz returns size of options value or 0

Returns

0 on success, 1 when name not found or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-options

```text
const char *
mnt_fs_get_options (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

pointer to string or NULL in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-passno

```text
int
mnt_fs_get_passno (struct libmnt_fs *fs);

Parameters

fs fstab/mtab entry pointer

Returns

"pass number on parallel fsck".
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-source

```text
const char *
mnt_fs_get_source (struct libmnt_fs *fs);

Parameters

fs struct libmnt_file (fstab/mtab/mountinfo) fs

Returns

mount source. Note that the source could be unparsed TAG (LABEL/UUID). See =
also mnt_fs_get_srcpath() and mnt_fs_get_tag().
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-tag

```text
int
mnt_fs_get_tag (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char **name,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char **value)=
;

"TAG" is NAME=3DVALUE (e.g. LABEL=3Dfoo)

The TAG is the first column in the fstab file. The TAG or "srcpath" always =
has to be set for all entries.

See also mnt_fs_get_source().

char *src;
struct libmnt_fs *fs =3D mnt_table_find_target(tb, "/home", MNT_ITER_FORWAR=
D);

if (!fs)
goto err;

src =3D mnt_fs_get_srcpath(fs);
if (!src) {
char *tag, *val;
if (mnt_fs_get_tag(fs, &tag, &val) =3D=3D 0)
printf("%s: %s\n", tag, val); // LABEL or UUID
} else
printf("device: %s\n", src); // device or bind path

Parameters

fs fs

name returns pointer to NAME string

value returns pointer to VALUE string

Returns

0 on success or negative number in case a TAG is not defined.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-target

```text
const char *
mnt_fs_get_target (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

pointer to mountpoint path or NULL
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-fstype

```text
int
mnt_fs_match_fstype (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *types);

For more details see mnt_match_fstype().
Parameters

fs filesystem

types filesystem name or comma delimited list of filesystems

Returns

1 if fs type is matching to types , else 0. The function returns 0 when typ=
es is NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-options

```text
int
mnt_fs_match_options (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const char *options);

For more details see mnt_match_options().
Parameters

fs filesystem

options comma delimited list of options (and nooptions)

Returns

1 if fs type is matching to options , else 0. The function returns 0 when t=
ypes is NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-target

```text
int
mnt_fs_match_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *target,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct libmnt_cache *cache);

Possible are three attempts: 1) compare target with fs->target

2) realpath(target ) with fs->target

3) realpath(target ) with realpath(fs->target ) if fs is not from /proc/sel=
f/mountinfo.

However, if mnt_cache_set_targets(cache, mtab) was called, and the path tar=
get or fs->target is found in the mtab , the canonicalization is is not per=
formed (see mnt_resolve_target()).

The 2nd and 3rd attempts are not performed when cache is NULL.
Parameters

fs filesystem

target mountpoint path

cache tags/paths cache or NULL

Returns

1 if fs target is equal to target , else 0.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-prepend-options

```text
int
mnt_fs_prepend_options (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 const char *optstr);

Parses (splits) optstr and prepends the results to VFS, FS and userspace li=
sts of options.

If optstr is NULL, then fs is not modified and 0 is returned.
Parameters

fs fstab/mtab/mountinfo entry

optstr mount options

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-print-debug

```text
int
mnt_fs_print_debug (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE =
*file);

Parameters

fs fstab/mtab/mountinfo entry

file file stream

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-comment

```text
int
mnt_fs_set_comment (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 char *comm);

Note that the comment has to be terminated by '\n' (new line), otherwise th=
e whole filesystem entry will be written as a comment to the tabfile (e.g. =
fstab).
Parameters

fs fstab entry pointer

comm comment string

Returns

0 on success or <0 in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-freq

```text
int
mnt_fs_set_freq (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int freq);

Parameters

fs fstab/mtab entry pointer

freq dump frequency in days

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-fstype

```text
int
mnt_fs_set_fstype (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const =
char *fstype);

This function creates a private copy (strdup()) of fstype .
Parameters

fs fstab/mtab/mountinfo entry

fstype filesystem type

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-options

```text
int
mnt_fs_set_options (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 char *optstr);

Splits optstr to VFS, FS and userspace mount options and updates relevant p=
arts of fs .
Parameters

fs fstab/mtab/mountinfo entry pointer

optstr options string

Returns

0 on success, or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-passno


```text
int
mnt_fs_set_passno (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pa=
ssno);

Parameters

fs fstab/mtab entry pointer

passno pass number

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-source

```text
int
mnt_fs_set_source (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const =
char *source);

This function creates a private copy (strdup()) of source .
Parameters

fs fstab/mtab/mountinfo entry

source new source

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-target

```text
int
mnt_fs_set_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const =
char *tgt);

This function creates a private copy (strdup()) of tgt .
Parameters

fs fstab/mtab/mountinfo entry

tgt mountpoint

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-streq-target

```text
int
mnt_fs_streq_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *path);

Compares fs target path with path . The redundant slashes are ignored. This
function compares strings and does not canonicalize the paths. See also mor=
e
generic mnt_fs_match_target().

Parameters

fs fs

path mount point

Returns

1 if fs target path equal to path , otherwise 0.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-to-mntent

```text
int
mnt_fs_to_mntent (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mnten=
t **mnt);

Copies the information from fs to struct mntent mnt . If mnt is already set=
,
then the struct mntent items are reallocated and updated. See also
mnt_free_mntent().

Parameters

fs filesystem

mnt mount description (as described in mntent.h)

Returns

0 on success and a negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-new-fs

```text
struct libmnt_fs *
mnt_new_fs (void);

The initial refcount is 1, and needs to be decremented to release the resou=
rces of the filesystem.
Returns

newly allocated struct libmnt_fs.
```

### Functions specific/exclusive to `/proc/#/mountinfo`

- `mnt_fs_get_devno `
- `mnt_fs_get_fs_options `
- `mnt_fs_get_fstype `
- `mnt_fs_get_id `
- `mnt_fs_get_optional_fields `
- `mnt_fs_get_parent_id `
- `mnt_fs_get_propagation `
- `mnt_fs_get_root `
- `mnt_fs_get_target `
- `mnt_fs_get_tid `
- `mnt_fs_get_vfs_options `
- `mnt_fs_get_vfs_options_all `
- `mnt_fs_match_fstype `
- `mnt_fs_match_target `
- `mnt_fs_print_debug `
- `mnt_fs_strdup_options `
- `mnt_fs_streq_target `

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-devno

```text
dev_t
mnt_fs_get_devno (struct libmnt_fs *fs);

Parameters

fs /proc/self/mountinfo entry

Returns

value of st_dev for files on filesystem or 0 in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-fs-options

```text
const char *
mnt_fs_get_fs_options (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

pointer to superblock (fs-depend) mount option string or NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-fstype

```text
const char *
mnt_fs_get_fstype (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

pointer to filesystem type.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-id

```text
int
mnt_fs_get_id (struct libmnt_fs *fs);

Parameters

fs /proc/self/mountinfo entry

Returns

mount ID (unique identifier of the mount) or negative number in case of err=
or.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-optional-fields

```text
const char *
mnt_fs_get_optional_fields (struct libmnt_fs *fs);

Parameters

fs mountinfo entry pointer

Returns

pointer to string with mountinfo optional fields or NULL in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-parent-id

```text
int
mnt_fs_get_parent_id (struct libmnt_fs *fs);

Parameters

fs /proc/self/mountinfo entry

Returns

parent mount ID or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-propagation

```text
int
mnt_fs_get_propagation (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 unsigned long *flags);

Note that this function sets flags to zero if no propagation flags are foun=
d in
the mountinfo file. The kernel default is MS_PRIVATE, this flag is not stor=
ed
in the mountinfo file.

Parameters

fs mountinfo entry

flags returns propagation MS_* flags as present in the mountinfo file

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-root

```text
const char *
mnt_fs_get_root (struct libmnt_fs *fs);

Parameters

fs /proc/self/mountinfo entry

Returns

root of the mount within the filesystem or NULL
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-target

```text
const char *
mnt_fs_get_target (struct libmnt_fs *fs);

Parameters

fs fstab/mtab/mountinfo entry pointer

Returns

pointer to mountpoint path or NULL
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-tid

```text
pid_t
mnt_fs_get_tid (struct libmnt_fs *fs);

Parameters

fs /proc/tid/mountinfo entry

Returns

TID (task ID) for filesystems read from the mountinfo file
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-vfs-options

```text
const char *
mnt_fs_get_vfs_options (struct libmnt_fs *fs);

Parameters

fs fstab/mtab entry pointer

Returns

pointer to fs-independent (VFS) mount option string or NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-vfs-options-all

```text
char *
mnt_fs_get_vfs_options_all (struct libmnt_fs *fs);

Parameters

fs fstab/mtab entry pointer

Returns

pointer to newlly allocated string (can be freed by free(3)) or NULL in cas=
e of
error. The string contains all (including defaults) mount options.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-fstype

```text
int
mnt_fs_match_fstype (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *types);

For more details see mnt_match_fstype().
Parameters

fs filesystem

types filesystem name or comma delimited list of filesystems

Returns

1 if fs type is matching to types , else 0. The function returns 0 when typ=
es is NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-target

```text
int
mnt_fs_match_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *target,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct libmnt_cache *cache);

Possible are three attempts: 1) compare target with fs->target

2) realpath(target ) with fs->target

3) realpath(target ) with realpath(fs->target ) if fs is not from /proc/sel=
f/mountinfo.

However, if mnt_cache_set_targets(cache, mtab) was called, and the path tar=
get
or fs->target is found in the mtab , the canonicalization is is not perform=
ed
(see mnt_resolve_target()).

The 2nd and 3rd attempts are not performed when cache is NULL.
Parameters

fs filesystem

target mountpoint path

cache tags/paths cache or NULL

Returns

1 if fs target is equal to target , else 0.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-print-debug

```text
int
mnt_fs_print_debug (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE =
*file);

Parameters

fs fstab/mtab/mountinfo entry

file file stream

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-strdup-options

```text
char *
mnt_fs_strdup_options (struct libmnt_fs *fs);

Merges all mount options (VFS, FS and userspace) to one options string and
returns the result. This function does not modify fs .

Parameters

fs


fstab/mtab/mountinfo entry pointer

Returns

pointer to string (can be freed by free(3)) or NULL in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-streq-target

```text
int
mnt_fs_streq_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *path);

Compares fs target path with path . The redundant slashes are ignored. This
function compares strings and does not canonicalize the paths. See also mor=
e
generic mnt_fs_match_target().

Parameters

fs fs

path mount point

Returns

1 if fs target path equal to path , otherwise 0.
```

### Functions specific/exclusive to `/run/mount/utab`

- `mnt_fs_append_attributes `
- `mnt_fs_get_attribute `
- `mnt_fs_get_attributes `
- `mnt_fs_get_bindsrc `
- `mnt_fs_get_id `
- `mnt_fs_get_root `
- `mnt_fs_get_user_options `
- `mnt_fs_match_options `
- `mnt_fs_match_target `
- `mnt_fs_prepend_attributes `
- `mnt_fs_set_attributes `
- `mnt_fs_set_bindsrc `
- `mnt_fs_set_root `
- `mnt_fs_set_source `
- `mnt_fs_streq_target `

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-append-attributes

```text
int
mnt_fs_append_attributes (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const char *optstr);

Appends mount attributes. (See mnt_fs_set_attributes()).

Parameters

fs fstab/mtab/mountinfo entry

optstr options string

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-attribute

```text
int
mnt_fs_get_attribute (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const char *name,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char **value,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size_t *valsz);

Parameters

fs fstab/mtab/mountinfo entry pointer

name option name

value returns pointer to the beginning of the value (e.g. name=3DVALUE) or =
NULL

valsz returns size of options value or 0

Returns

0 on success, 1 when name not found or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-attributes

```text
const char *
mnt_fs_get_attributes (struct libmnt_fs *fs);

Parameters

fs fstab/mtab entry pointer

Returns

pointer to attributes string or NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-bindsrc

```text
const char *
mnt_fs_get_bindsrc (struct libmnt_fs *fs);

Parameters

fs /run/mount/utab entry

Returns

full path that was used for mount(2) on MS_BIND
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-id

```text
int
mnt_fs_get_id (struct libmnt_fs *fs);

Parameters

fs /proc/self/mountinfo entry

Returns

mount ID (unique identifier of the mount) or negative number in case of err=
or.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-root

```text
const char *
mnt_fs_get_root (struct libmnt_fs *fs);

Parameters

fs /proc/self/mountinfo entry

Returns

root of the mount within the filesystem or NULL
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-user-options

```text
const char *
mnt_fs_get_user_options (struct libmnt_fs *fs);

Parameters

fs fstab/mtab entry pointer

Returns

pointer to userspace mount option string or NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-options

```text
int
mnt_fs_match_options (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const char *options);

For more details see mnt_match_options().
Parameters

fs filesystem

options comma delimited list of options (and nooptions)

Returns

1 if fs type is matching to options , else 0. The function returns 0 when t=
ypes is NULL.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-match-target

```text
int
mnt_fs_match_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *target,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct libmnt_cache *cache);

Possible are three attempts: 1) compare target with fs->target

2) realpath(target ) with fs->target

3) realpath(target ) with realpath(fs->target ) if fs is not from /proc/sel=
f/mountinfo.

However, if mnt_cache_set_targets(cache, mtab) was called, and the path tar=
get
or fs->target is found in the mtab , the canonicalization is is not perform=
ed
(see mnt_resolve_target()).

The 2nd and 3rd attempts are not performed when cache is NULL.

Parameters

fs filesystem

target mountpoint path

cache tags/paths cache or NULL

Returns

1 if fs target is equal to target , else 0.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-prepend-attributes

```text
int
mnt_fs_prepend_attributes (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *optstr);

Prepends mount attributes. (See mnt_fs_set_attributes()).

Parameters

fs fstab/mtab/mountinfo entry

optstr options string

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-attributes

```text
int
mnt_fs_set_attributes (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const char *optstr);

Sets mount attributes. The attributes are mount(2) and mount(8) independent
options, these options are not sent to the kernel and are not interpreted b=
y
libmount. The attributes are stored in /run/mount/utab only.

The attributes are managed by libmount in userspace only. It's possible tha=
t
information stored in userspace will not be available for libmount after
CLONE_FS unshare. Be careful, and don't use attributes if possible.

Parameters

fs fstab/mtab/mountinfo entry

optstr options string

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-bindsrc

```text
int
mnt_fs_set_bindsrc (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 char *src);

Parameters

fs filesystem

src path

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-root

```text
int
mnt_fs_set_root (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *p=
ath);

Parameters

fs mountinfo entry

path root path

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-source

```text
int
mnt_fs_set_source (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const =
char *source);

This function creates a private copy (strdup()) of source .

Parameters

fs fstab/mtab/mountinfo entry

source new source

Returns

0 on success or negative number in case of error.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-streq-target

```text
int
mnt_fs_streq_target (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *path);

Compares fs target path with path . The redundant slashes are ignored. This
function compares strings and does not canonicalize the paths. See also mor=
e
generic mnt_fs_match_target().

Parameters

fs fs

path mount point

Returns

1 if fs target path equal to path , otherwise 0.
```

### Functions specific/exclusive to `/proc/swaps`

- `mnt_fs_get_priority `
- `mnt_fs_get_size `
- `mnt_fs_get_swaptype `
- `mnt_fs_get_usedsize `
- `mnt_fs_set_priority `

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-priority

```text
int
mnt_fs_get_priority (struct libmnt_fs *fs);

Parameters

fs /proc/swaps entry

Returns

priority
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-size

```text
off_t
mnt_fs_get_size (struct libmnt_fs *fs);

Parameters

fs /proc/swaps entry

Returns

size
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-swaptype

```text
const char *
mnt_fs_get_swaptype (struct libmnt_fs *fs);

Parameters

fs /proc/swaps entry

Returns

swap type or NULL
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-get-usedsize

```text
off_t
mnt_fs_get_usedsize (struct libmnt_fs *fs);

Parameters

fs /proc/swaps entry

Returns

used size

```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-priority

```text
int
mnt_fs_set_priority (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int prio);

Parameters

fs /proc/swaps entry


prio priority

Returns

0 or -1 in case of error

Since: 2.28
```


M4 - What role does the `userdata` field in `libmnt_fs` play? For which fil=
e
entry is it necessary? `fstab`, `mountinfo`, `utab`, `swaps`?

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libmount/src/mountP.h#L237

```C
void *userdata; /* library independent data */
```


M5 - Could anyone provide more information about the format used by the ent=
ries
in `/run/mount/utab`? Are the definitions reproduced below correct?

By reading the code for the `mnt_parse_utab_line` function, I identified th=
e
following keys for possible key-value pairs in `/run/mount/utab`.

A cursory search on the web yielded these definitions:
- `SRC`: the mounted device,
- `TARGET`: the device=E2=80=99s mount point,
- `ROOT`: ??
- `BINDSRC`: the source of a bind mount,
- `OPTS`: mount options,
- `ATTRS`: options independent from those used by the mount syscall and mou=
nt
=C2=A0 command. They are neither sent to the kernel, nor interpreted by lib=
mount. They
=C2=A0 are stored in /run/mount/utab, and managed by libmount in userspace =
only.

https://github.com/util-linux/util-linux/blob/8aa25617467a1249669cff7240ca3=
1973bf9a127/libmount/src/tab_parse.c#L326-L368

```C
if (!fs->id && !strncmp(p, "ID=3D", 3)) {
int rc =3D 0;


end =3D next_s32(p + 3, &fs->id, &rc);
if (!end || rc)
return rc;


} else if (!fs->source && !strncmp(p, "SRC=3D", 4)) {
char *v =3D unmangle(p + 4, &end);
if (!v)
goto enomem;
if (__mnt_fs_set_source_ptr(fs, v))
free(v);


} else if (!fs->target && !strncmp(p, "TARGET=3D", 7)) {
fs->target =3D unmangle(p + 7, &end);
if (!fs->target)
goto enomem;


} else if (!fs->root && !strncmp(p, "ROOT=3D", 5)) {
fs->root =3D unmangle(p + 5, &end);
if (!fs->root)
goto enomem;


} else if (!fs->bindsrc && !strncmp(p, "BINDSRC=3D", 8)) {
fs->bindsrc =3D unmangle(p + 8, &end);
if (!fs->bindsrc)
goto enomem;


} else if (!fs->user_optstr && !strncmp(p, "OPTS=3D", 5)) {
fs->user_optstr =3D unmangle(p + 5, &end);
if (!fs->user_optstr)
goto enomem;


} else if (!fs->attrs && !strncmp(p, "ATTRS=3D", 6)) {
fs->attrs =3D unmangle(p + 6, &end);
if (!fs->attrs)
goto enomem;


} else {
/* unknown variable */
while (*p && *p !=3D ' ') p++;
}
```


M6 - Can the `SRC` key mentioned in question `M5` have a:
- tag (UUID, PARTUUID, LABEL, etc.)
- network ID (Samba: `smb://ip-address-or-hostname/shared-dir`, SSHFS:
=C2=A0 `user@ip-address-or-hostname:/shared-dir`, etc.)
=C2=A0as value? (e.g. SRC=3D"UUID=3Dac4f36bf-191b-4fb0-b808-6d7fc9fc88be")


M7 - What does `mnt_fs_set_root` do? Is it meant for `/proc/self/mountinfo`=
,
`/run/mount/utab`, or both?

Although `libmnt_fs` can represent a line in `/proc/self/mountinfo`, files =
in
`/proc` are usually read-only, managed directly by the Linux kernel.

However, the docstring of `mnt_fs_set_root` says that it is supposed to mod=
ify
an entry in `/proc/self/mountinfo`.

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-root

```text
int
mnt_fs_set_root (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *p=
ath);

Parameters

=C2=A0 =C2=A0 fs mountinfo entry
=C2=A0 =C2=A0 path root path

Returns

=C2=A0 0 on success or negative number in case of error.

```


M8 - What is `mnt_context_apply_fstab` supposed to do?

The documentation only says "This function is optional".

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Library-high-level-context.html#mnt-context-apply-fstab

```text
int
mnt_context_apply_fstab (struct libmnt_context *cxt);

This function is optional.

Parameters

=C2=A0 cxt mount context

Returns

=C2=A0 0 on success, negative number in case of error.
```


M9 - Why does `mnt_optstr_prepend_option("", "ro", "recursive")` return
`"ro=3Drecursive,"`, but `mnt_optstr_append_option("", "ro", "recursive")` =
return
`"ro=3Drecursive"`? What is the extra comma after the keyword `recursive` o=
utput
by `mnt_optstr_prepend_option` for?

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Options-string.html#mnt-optstr-prepend-option

```text
int
mnt_optstr_prepend_option (char **optstr,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *value);

Parameters

optstr option string or NULL, returns a reallocated string

name value name

value value

Returns

0 on success or <0 in case of error. After an error the optstr should be un=
modified.
```

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Options-string.html#mnt-optstr-append-option

```text
int
mnt_optstr_append_option (char **optstr,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const char *name,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const char *value);

Parameters

optstr option string or NULL, returns a reallocated string

name value name

value value

Returns

0 on success or <0 in case of error. After an error the optstr should be un=
modified.
```


M10 - In option maps, what does using the mask `MNT_INVERT` do to mountflag=
s
(e.g. `noatime`, `suid`, others)?

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Option-maps.html#MNT-INVERT:CAPS

```text
#define MNT_INVERT (1 << 1) /* invert the mountflag */
```


M11 - Which definition is correct, or am I conflating two notions?

The function `mnt_fs_set_freq` sets the backup frequency (in days) of a dri=
ve in
`/etc/fstab`. According to `libmount`, it takes an integer value.

But, from [An introduction to the Linux /etc/fstab
file](https://www.redhat.com/en/blog/etc-fstab) the value in the fifth colu=
mn
on each line` in `/etc/fstab` can only take two values, `0 =3D no backup` o=
r `1 =3D
dump utility backup of a partition`.



> Backup Operation: (the first digit) this is a binary system where 1 =3D d=
ump
> utility backup of a partition. 0 =3D no backup. This is an outdated backu=
p
> method and should NOT be used.

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/libmount-d=
ocs/libmount-Filesystem.html#mnt-fs-set-freq

```text
int
mnt_fs_set_freq (struct libmnt_fs *fs,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int freq);

Parameters

fs fstab/mtab entry pointer

freq dump frequency in days

Returns

0 on success or negative number in case of error.
```

Thank you for reading this far. Please accept my apologies for making you g=
o
through this wall of text m(__)m
