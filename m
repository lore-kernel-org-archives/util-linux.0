Return-Path: rjones@redhat.com
Date: Mon, 4 Feb 2013 18:23:38 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: libguestfs@redhat.com
Cc: berrange@redhat.com, kzak@redhat.com, util-linux@vger.kernel.org
Subject: [Libguestfs] Should we always do wipefs before mkfs?  Discuss ...
Message-ID: <20130204182338.GA15222@rhmail.home.annexia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>


https://bugzilla.redhat.com/show_bug.cgi?id=907554

In particular comments 2 & 3.

We could change libguestfs's guestfs_mkfs (internally) so it always
does an implicit wipefs on the filesystem.  wipefs is not too onerous --
in particular I believe it only writes to a few chosen areas of the
disk.  Especially considering that we're about to run mkfs anyway
which for some filesystems writes a lot of blocks.

Thoughts?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
