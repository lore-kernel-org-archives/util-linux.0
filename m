Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86713B58A
	for <util-linux@vger.kernel.org>; Sun,  8 Jun 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749419224; cv=none; b=c19a5JKo18MDsSDptZL5BeEOAvBXsyuq+Upl7n9lwur2k8EQbYkZb/PbFggnDnrqTQKQ0WpqQSKzBj3lNQPiVarQFguU/t4nxjUsNoJZu/mlMpD4tpU2R3T3JL8UF/faJ9ZE53iktcDB12LNsu6m2Wr3qAGtBqaWgw9J0jELUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749419224; c=relaxed/simple;
	bh=UQOhlhgiBpJKPPcgwfecHQ7ynsz1C4mbC3KMzYjEC0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHXKdBbOb/FM5/XFWsPmYc13kY9SNMbsyjh1IN8nBZYikaUZ9TavEqdCfLdSIkujxg2wXSTK9za48UfwW+aq51lKUDblDQLvl6FwKTAxhiLg3qcLTuBpWpFT+PuwGaCd3VIBYpp954bKvV+Brkv6rw5wqtkP6OY2DxYBckm1JhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=XDkIKdFW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="XDkIKdFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1749418639; bh=UQOhlhgiBpJKPPcgwfecHQ7ynsz1C4mbC3KMzYjEC0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDkIKdFWgqN0r2F+PMHEpq/3DMXalzHDB0/O0H1Rc2N+f0E7lYbPYGJXg+bvFpEIf
	 jPrZwIJV6Mo9UGkIa1bneDlXdGzBLWdeQZ0QvGfl9Y5cfPF9sSB+IGw95RQeDg/g7B
	 OC8sgnGdbyurLkLCvb/rXYZ7gB7sMk/4euWmwc7o=
Date: Sun, 8 Jun 2025 23:37:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Nick Piaddo <nick.piaddo@protonmail.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: Questions about util-linux
Message-ID: <507380d5-bf3e-4360-934c-db701df80e01@t-8ch.de>
References: <IM79iX-yrSm2eLiLvGaZqJbIZaqT9SuLnpz0GuSvYOizxuYCJucKrIfwPYCjCos13Y4njHyPz3ftnmz6y5MrsTr6plHxqBIHUDF59iH-GlA=@protonmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IM79iX-yrSm2eLiLvGaZqJbIZaqT9SuLnpz0GuSvYOizxuYCJucKrIfwPYCjCos13Y4njHyPz3ftnmz6y5MrsTr6plHxqBIHUDF59iH-GlA=@protonmail.com>

On 2025-06-05 10:25:07+0000, Nick Piaddo wrote:
> **As my first post on this mailing list, please advise if "this is NOT the way..."**
> 
> Hi,
> 
> I am developing a personal project in Rust for which I need to probe block
> devices, create, and mount partitions; `libblkid`, `libfdisk`, and `libmount`
> fit the bill perfectly.

So you want to use the original C libraries and wrap them from rust,
correct? Not reimplement them.

These libraries are LGPL. Your crates, for which are asking about
internal details are licensed as Apache or MIT, which looks iffy.
Especially if the libraries are then linked statically.
Best stick to the LGPL.

> So, I am writing Rust bindings for `util-linux-2.39` (published on `crates.io`):
> - `rsblkid`: [crate](https://crates.io/crates/rsblkid)  [docs](https://docs.rs/rsblkid/latest/rsblkid/)
> - `rsfdisk`: [crate](https://crates.io/crates/rsfdisk)  [docs](https://docs.rs/rsfdisk/latest/rsfdisk/)
> - `rsmount`: [crate](https://crates.io/crates/rsmount)  [docs](https://docs.rs/rsmount/latest/rsmount/)
> 
> They are first drafts with APIs that are still in flux, with low test coverage,
> and some C functions are still missing their Rust equivalents.
> 
> Even after going through:
> - the source code of each C library,
> - their documentation pages,
> - the manpages of `blkid`,  `fdisk`, `mount`,

Also look at libblkid(3)

> - and searching the net for as much information as I could find,
> 
> the docs of each crate still reflects my limited knowledge of `util-linux`.
> 
> So, I do have a few questions I hope experts on this list may be able to
> answer (see further down). **Warning:** It's a long read!

These are a lot of questions. I'll respond to the ones I have
answers to. The amount most likely reduces your chances to get
responses.
If these questions were generated automatically please mention it.

> Nick
> 
> ## How are questions structured?
> 
> Most questions follow the pattern described below:

<snip>

> Please mention the ID of the question you are answering, or are seeking
> clarifications for. It will make the conversation easier to follow.

I will reply inline. Right below the question.
This will keep the context very celar.

> Thanks! (^-^)b
> 
> ## General questions
> 
> G1 - Would it be possible to provide a way to define a destructor for functions
> registering callbacks, long-lived or otherwise?
> 
> Interoperating with C, and registering callback functions requires Rust to
> allocate state data on the heap.
> 
> From the [Rustonomicon](https://doc.rust-lang.org/nomicon/ffi.html#destructors)
> we learn that:
> > Foreign libraries often hand off ownership of resources to the calling code.
> > When this occurs, we must use Rust's destructors to provide safety and
> > guarantee the release of these resources (especially in the case of panic).
> 
> To free dynamically allocated Rust data, C functions registering callbacks
> should have a signature like the one shown below:
> 
> ```C
> void widget_register_callback(
>     widget_t *widget,
>     void *data,
>     void (*callback)(void*, event_t),
>     void (*destroy)(void*)
> );
> ```
> 
> See this blog post [Neat Rust Tricks: Passing Rust Closures to
> C](http://blog.sagetheprogrammer.com/neat-rust-tricks-passing-rust-closures-to-c)
> for a presentation of what I dream `util-linux` had. (╥﹏╥)つ
> 
> While reading `util-linux`'s source code, I identified three types of functions
> to register callbacks:
> 
> - functions for which it is essentially impossible to create Rust bindings,
>   case in point: `fdisk_table_sort_partitions` (see documentation further down).
>   This function has a signature that looks like the example below.

This should only be true for closures. If you use a regular function with
static lifetime fdisk_table_sort_partitions() should work fine.
A closure does not make sense here anyways.

> - functions for registering long-lived callbacks with a signature like the one
>   shown below
> 
>   ```C
>   void widget_register_callback(
>       widget_t *widget,
>       void (*callback)(void*, event_t),
>   );
>   ```
>   For example, `mnt_table_set_parser_errcb` that acts on a `struct
>   libmnt_table`. This structure has an internal field to store a data pointer,
>   along with specialized accessor functions to get/set it (respectively
>   `mnt_table_get_userdata `, and `mnt_table_set_userdata `). However, lacking a
>   way to define a destructor, this function will leak memory each time it is
>   called to replace a callback.

The mnt_table is owned by your rust code. So the rust code can clean up
the userdata together with the mnt_table.

> - functions for registering short-lived callbacks with a signature like the one
>   shown below
> 
>   ```C
>   void widget_register_callback(
>       widget_t *widget,
>       void *data,
>       void (*callback)(void*, event_t),
>   );
>   ```
>   For example, `mnt_table_find_next_fs` which is the closest to the ideal form.
>   Although it lacks a way to define a destructor, being short-lived, it allows
>   the enclosing Rust binding to take care of releasing resources allocated on
>   the heap.

Here the data should be owned by the function calling
mnt_table_find_next_fs() and it will be cleaned up nicely when the
function returns.

> 
> https://github.com/util-linux/util-linux/blob/stable/v2.39/libfdisk/src/fdiskP.h#L200-L205

Why use v2.39 and not the latest versions?
Some of your problems may already be resolved there.

<snip a lot of blablabla>

> G2 - How can I create device images that will trigger errors when running
> unit-tests?

<blabla>

> Knowing how to create an intentionally broken device image would be wonderful.
> It would allow me to increase test coverage of my Rust-bindings.

This question does not make sense. It's not the responsibility of your
code to look at the raw image file.
util-linux is fuzzed with random input as part of oss-fuzz.

> ## libblkid
> 
> B1 - Are there public accessor functions on the roadmap of `libblkid` for
> reading the private fields `bid_pri`, `bid_devno`, and `bid_time` in
> `blkid_dev_struct`?
> 
> For the moment, I can not accurately reproduce the way data about a
> `blkid_struct_dev` is printed in `/run/blkid/blkid.tab` due to not being able
> to access the relevant fields.

blkid.tab is an internal file. Why do you need to reproduce it?

<snip>

> B2 - Does anyone know what the function `blkid_dev_set_search` is supposed to
> do?
> 
> There are no docstrings for this function. Although I read its source code, I
> could not figure out its purpose.  <('^-^)
> 
> https://github.com/util-linux/util-linux/blob/stable/v2.39/libblkid/src/dev.c#L150-L172

Seems quite obvious to me. It allows you to search for files with a
certain tag value.

<snip the code>

Why is all this pointless code in the email?
If somebody is not capable of looking up the code they won't be able to
help anyways.

> B3 -  Do I define `size` as `uint64_t` or `int64_t`?
> 
> The `size` field in `struct blkid_struct_probe` is of type `uint64_t`. But,
> according to the documentation, its accessor function `blkid_probe_get_sectors`
> may return `-1` in case of error.

`struct blkid_struct_probe` is internal. The types it uses are of no
concern to your code. Stick to the public interface.

> Reading the code of `blkid_probe_get_sectors`, I can see that it just divides
> `size` by 512 which would never return a negative value (see below).

If the function is documented as being able to return an error, then
write your code with this consideration.

<snip>

> B4 - Is the documentation out-of-date or just anticipating a future change?
> 
> The function `blkid_probe_set_sectorsize` always returns `0`, but its docstring
> says otherwise.

The docstring defines the interface, trust it.

<snip>

> B5 - Is there a list of all file systems supported by `libblkid`?

> By searching the source code, I managed to constitute a list of supported file
> systems gathered in the enum
> [`FileSystem`](https://docs.rs/rsblkid/latest/rsblkid/partition/enum.FileSystem.html#variants)
> in `rsblkid`.
> 
> It would be nice if I could double-check its accuracy from an official
> reference.

blkid --list-filesystems

This is documented.

> B6 - Is there a list of all tags supported by `libblkid`?
> 
> By searching the source code, I managed to constitute a list of supported tags
> gathered in the enum
> [`Tag`](https://docs.rs/rsblkid/latest/rsblkid/device/enum.Tag.html#variants)
> in `rsblkid`.
> 
> It would be nice if I could double-check its accuracy from an official
> reference.

This is documented in libblkid(3).
I wouldn't represent this as enum, though.

<snip>

> ## libmount
> 
> M1 - Does `libmount` plan to provide public functions to access/set the
> private `fmt` field in `struct libmnt_table`?
> 
> From what I understand, `struct libmnt_table` is a generic data type used to
> represent either of the following files:
> - `/etc/fstab`
> - `/proc/#/mountinfo`
> - `/run/mount/utab`
> - `/proc/swaps`
> 
> The `fmt` field helps distinguish each subtype, and being able to set it would
> make it easier for me to instantiate the appropriate type Rust-side (i.e.
> `FsTab`, `MountInfo`, `UTab`, `Swaps`).

Why do you need this?

<snip>

> M2 - If we were to split `struct libmnt_fs` into one type per file format,
> would we get data types resembling `struct entry_fstab`, `struct
> entry_mountinfo`, `struct entry_utab`, `struct_swaps` described below?
> 
> As far as I can tell, `struct libmnt_fs` is a multi-purpose data type
> representing a line in either of the following files:
> - `/etc/fstab`
> - `/proc/#/mountinfo`
> - `/run/mount/utab`
> - `/proc/swaps`
> 
> Each file has a distinct format. So, some fields present in `struct libmnt_fs`
> do not apply to certain files.

All of this is private implementation why do you need it?

<snip>

> M3 - About `struct libmnt_fs` mentioned in question `M2`, is the following a
> good partition of which subsets of functions, acting on the struct, are
> specific/exclusive to each type of file entry?  (We assume that items not in
> a union of the subsets below are shared between line types)
> 
> ### Functions specific/exclusive to `/etc/fstab`
> 
> - `mnt_fs_append_comment`
> - `mnt_fs_append_options `
> - `mnt_fs_get_comment `
> - `mnt_fs_get_freq `
> - `mnt_fs_get_fstype `
> - `mnt_fs_get_option `
> - `mnt_fs_get_options `
> - `mnt_fs_get_passno `
> - `mnt_fs_get_source `
> - `mnt_fs_get_tag `
> - `mnt_fs_get_target `
> - `mnt_fs_match_fstype `
> - `mnt_fs_match_options `
> - `mnt_fs_match_target `
> - `mnt_fs_prepend_options `
> - `mnt_fs_print_debug `
> - `mnt_fs_set_comment `
> - `mnt_fs_set_freq `
> - `mnt_fs_set_fstype `
> - `mnt_fs_set_options `
> - `mnt_fs_set_passno `
> - `mnt_fs_set_source `
> - `mnt_fs_set_target `
> - `mnt_fs_streq_target `
> - `mnt_fs_to_mntent `
> - `mnt_new_fs `

This question does not make sense.

> ### Functions specific/exclusive to `/proc/#/mountinfo`
> 
> - `mnt_fs_get_devno `
> - `mnt_fs_get_fs_options `
> - `mnt_fs_get_fstype `
> - `mnt_fs_get_id `
> - `mnt_fs_get_optional_fields `
> - `mnt_fs_get_parent_id `
> - `mnt_fs_get_propagation `
> - `mnt_fs_get_root `
> - `mnt_fs_get_target `
> - `mnt_fs_get_tid `
> - `mnt_fs_get_vfs_options `
> - `mnt_fs_get_vfs_options_all `
> - `mnt_fs_match_fstype `
> - `mnt_fs_match_target `
> - `mnt_fs_print_debug `
> - `mnt_fs_strdup_options `
> - `mnt_fs_streq_target `

This list also does not make sense.

> ### Functions specific/exclusive to `/run/mount/utab`
> 
> - `mnt_fs_append_attributes `
> - `mnt_fs_get_attribute `
> - `mnt_fs_get_attributes `
> - `mnt_fs_get_bindsrc `
> - `mnt_fs_get_id `
> - `mnt_fs_get_root `
> - `mnt_fs_get_user_options `
> - `mnt_fs_match_options `
> - `mnt_fs_match_target `
> - `mnt_fs_prepend_attributes `
> - `mnt_fs_set_attributes `
> - `mnt_fs_set_bindsrc `
> - `mnt_fs_set_root `
> - `mnt_fs_set_source `
> - `mnt_fs_streq_target `

Why is for example `mnt_fs_print_debug` missing?
This looks random.
Don't try to "improve" the API. It will break at some point.

<snip>

> M5 - Could anyone provide more information about the format used by the entries
> in `/run/mount/utab`? Are the definitions reproduced below correct?
> 
> By reading the code for the `mnt_parse_utab_line` function, I identified the
> following keys for possible key-value pairs in `/run/mount/utab`.

Why? It is a private implementation detail.

<snip>

> M6 - Can the `SRC` key mentioned in question `M5` have a:
> - tag (UUID, PARTUUID, LABEL, etc.)
> - network ID (Samba: `smb://ip-address-or-hostname/shared-dir`, SSHFS:
>   `user@ip-address-or-hostname:/shared-dir`, etc.)
>  as value? (e.g. SRC="UUID=ac4f36bf-191b-4fb0-b808-6d7fc9fc88be")

Still a private implementation detail.

> M7 - What does `mnt_fs_set_root` do? Is it meant for `/proc/self/mountinfo`,
> `/run/mount/utab`, or both?
> 
> Although `libmnt_fs` can represent a line in `/proc/self/mountinfo`, files in
> `/proc` are usually read-only, managed directly by the Linux kernel.
> 
> However, the docstring of `mnt_fs_set_root` says that it is supposed to modify
> an entry in `/proc/self/mountinfo`.

It modifies the entry in memory.

> M8 - What is `mnt_context_apply_fstab` supposed to do?

Looks to me like it extends the context with information found in
/etc/fstab.

<snip>

> Thank you for reading this far. Please accept my apologies for making you go
> through this wall of text m(__)m

Please don't quote all this code.


Thomas
