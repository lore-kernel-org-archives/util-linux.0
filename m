Return-Path: gmazyland@gmail.com
Message-ID: <50AB9CB9.3040104@gmail.com>
Date: Tue, 20 Nov 2012 16:07:37 +0100
From: Milan Broz <gmazyland@gmail.com>
MIME-Version: 1.0
To: "Richard W.M. Jones" <rjones@redhat.com>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] wipefs: Add --force option
References: <20121119154116.GA28909@rhmail.home.annexia.org> <20121120111634.GH20338@x2.net.home> <20121120135246.GB2006@x2.net.home> <20121120144111.GN1444@rhmail.home.annexia.org>
In-Reply-To: <20121120144111.GN1444@rhmail.home.annexia.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 11/20/2012 03:41 PM, Richard W.M. Jones wrote:

> In fact the problem case is where you try to wipe a device which
> contains a volume groups and a logical volume; note the LVs don't
> contain filesystems, and nothing is mounted.

Well there is a problem. While you can wipe part table, kernel will
reload it and destroy all obsolete partitions.
There should not be problem if it contains lvm, only if it contains
active LVs mapped.

If there are active device-mapper devices (either created by kpartx,
lvm, crypt, ...) you will lost metadata and cannot remove them
using standard tools, you are forced to do it with dmsetup later.

So wipe part table is fine, but not if partition is mounted or
mapped... You should remove mapping first.

And --force here should be used as a last resort - why not deactivate
mapped device on top first?
It should not be big problem (I think someone wrote this using
lsblk --inverse).

Using force in this situation just creates problem later.

(I am not against the patch, it should have --force option but it
should be used very carefully.)

> libguestfs: trace: lvcreate_free "LV" "VG" 100
> libguestfs: trace: lvcreate_free = 0
> libguestfs: trace: wipefs "/dev/sda"
> libguestfs: trace: wipefs = -1 (error)

IMHO lvcreate implicitly activates device.
Try lvcreate -a n !

Milan
