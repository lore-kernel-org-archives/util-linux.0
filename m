Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab2KTOlP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Nov 2012 09:41:15 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAKEfE6d023315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 20 Nov 2012 09:41:15 -0500
Date: Tue, 20 Nov 2012 14:41:11 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wipefs: Add --force option
Message-ID: <20121120144111.GN1444@rhmail.home.annexia.org>
References: <20121119154116.GA28909@rhmail.home.annexia.org>
 <20121120111634.GH20338@x2.net.home>
 <20121120135246.GB2006@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121120135246.GB2006@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 20, 2012 at 02:52:46PM +0100, Karel Zak wrote:
> On Tue, Nov 20, 2012 at 12:16:34PM +0100, Karel Zak wrote:
> > On Mon, Nov 19, 2012 at 03:41:16PM +0000, Richard W.M. Jones wrote:
> > > This change adds the --force option which, when used, undoes the above
> > > flag change.  However you still have to use --force most of the time
> > > when erasing something that isn't a plain unmounted filesystem.
> > 
> >  I'll improve the code. It's stupid disadvantage that --force is
> >  necessary for things like partitions tables. We have to use
> >  O_EXCL more carefully.
> 
>  ... it seems that this is unnecessary. It's possible to delete
>  partition table (open with O_EXCL) if any of the partitions is not
>  mounted. It seems that only mount(2) has any impact to O_EXCL.
> 
>  I guess that --force is enough.

Sorry, that was my mistake.  My initial report had a simplifying
assumption that wasn't correct.

In fact the problem case is where you try to wipe a device which
contains a volume groups and a logical volume; note the LVs don't
contain filesystems, and nothing is mounted.

A simple reproducer is:

$ guestfish -N lv wipefs /dev/sda
libguestfs: error: wipefs: wipefs: error: /dev/sda: probing initialization failed: Device or resource busy

Adding -x shows what's going on:

$ guestfish -N lv wipefs /dev/sda -x
libguestfs: trace: set_pgroup true
libguestfs: trace: set_pgroup = 0
libguestfs: trace: add_drive "test1.img"
libguestfs: trace: add_drive = 0
libguestfs: trace: is_config
libguestfs: trace: is_config = 1
libguestfs: trace: launch
libguestfs: trace: get_tmpdir
libguestfs: trace: get_tmpdir = "/tmp"
libguestfs: trace: get_cachedir
libguestfs: trace: get_cachedir = "/var/tmp"
libguestfs: trace: disk_format "/home/rjones/test1.img"
libguestfs: trace: disk_format = "raw"
libguestfs: trace: get_cachedir
libguestfs: trace: get_cachedir = "/var/tmp"
libguestfs: trace: launch = 0
libguestfs: trace: part_disk "/dev/sda" "mbr"
libguestfs: trace: part_disk = 0
libguestfs: trace: pvcreate "/dev/sda1"
libguestfs: trace: pvcreate = 0
libguestfs: trace: vgcreate "VG" "/dev/sda1"
libguestfs: trace: vgcreate = 0
libguestfs: trace: lvcreate_free "LV" "VG" 100
libguestfs: trace: lvcreate_free = 0
libguestfs: trace: wipefs "/dev/sda"
libguestfs: trace: wipefs = -1 (error)
libguestfs: error: wipefs: wipefs: error: /dev/sda: probing initialization failed: Device or resource busy
libguestfs: trace: close
libguestfs: trace: internal_autosync
libguestfs: trace: internal_autosync = 0

Use -v to get more details.

I don't want to claim this is a bug, but it is certainly a change in
behaviour, and we want the --force option in libguestfs so we can say
"just do it".

By the way:

Just a partition + a PV: wipefs doesn't need to be forced.
guestfish -N part pvcreate /dev/sda1 : wipefs /dev/sda

Just a partition + a PV + a VG: wipefs doesn't need to be forced.
guestfish -N part pvcreate /dev/sda1 : vgcreate VG /dev/sda1 : wipefs /dev/sda

Partition + PV + VG + LV (but no filesystem): wipefs needs --force.
[for example see above]

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming blog: http://rwmj.wordpress.com
Fedora now supports 80 OCaml packages (the OPEN alternative to F#)
http://cocan.org/getting_started_with_ocaml_on_red_hat_and_fedora
