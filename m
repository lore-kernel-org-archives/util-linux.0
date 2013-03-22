Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:34635 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423062Ab3CVVzK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Mar 2013 17:55:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1UJ9vv-0008R6-Ic
	for util-linux@vger.kernel.org; Fri, 22 Mar 2013 22:55:31 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 22 Mar 2013 22:55:31 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 22 Mar 2013 22:55:31 +0100
To: util-linux@vger.kernel.org
From: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
Subject: umount crashes when trying to umount a non-mountpoint
Date: Fri, 22 Mar 2013 23:54:52 +0200
Message-ID: <kiijva$3gc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If I run `umount /foo` where /foo is an existing directory, but not a
mountpoint, `umount` (v2.23-rc1) crashes in mnt_copy_fs() instead of
printing the usual "not mounted" message:

> Program terminated with signal 11, Segmentation fault.
> #0  mnt_copy_fs (dest=0x1fd2ea0, src=0x2) at libmount/src/fs.c:140
> 140		dest->id         = src->id;
> (gdb) bt
> #0  mnt_copy_fs (dest=0x1fd2ea0, src=0x2) at libmount/src/fs.c:140
>         org = 0x1fd2ea0
> #1  0x00007f5adb9a8a70 in lookup_umount_fs (cxt=0x1fd2da0)
>     at libmount/src/context_umount.c:212
>         tgt = 0x1fd2f70 "\200@\375\001"
>         fs = 0x2
>         rc = 1
> #2  mnt_context_prepare_umount (cxt=cxt@entry=0x1fd2da0)
>     at libmount/src/context_umount.c:684
>         rc = <optimized out>
>         __PRETTY_FUNCTION__ = "mnt_context_prepare_umount"
> #3  0x00007f5adb9a9e48 in mnt_context_umount (cxt=cxt@entry=0x1fd2da0)
>     at libmount/src/context_umount.c:839
>         rc = <optimized out>
>         __PRETTY_FUNCTION__ = "mnt_context_umount"
> #4  0x00000000004035a5 in umount_one (cxt=0x1fd2da0, spec=<optimized out>)
>     at sys-utils/umount.c:296
>         rc = <optimized out>
> #5  0x0000000000402c58 in main (argc=<optimized out>, argv=<optimized out>)
>     at sys-utils/umount.c:627
> ...
> (gdb) p dest
> $1 = (struct libmnt_fs *) 0x608ea0
> (gdb) p src
> $2 = (const struct libmnt_fs *) 0x2

-- 
Mantas Mikulėnas <grawity@gmail.com>

