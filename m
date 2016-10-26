Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50978 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758438AbcJZJaG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 05:30:06 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MSMr9-1cSejD21IR-00TSq0 for
 <util-linux@vger.kernel.org>; Wed, 26 Oct 2016 11:30:00 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: libfdisk show stopper on i586?
Date: Wed, 26 Oct 2016 11:29:59 +0200
References: <201610260000.12844.sweet_f_a@gmx.de>
In-Reply-To: <201610260000.12844.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610261129.59654.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 26 October 2016, Ruediger Meier wrote:
> Hi,
>
> looks like some of the last commits between v2.29-rc2-1-ge5cc93b
> and v2.29-rc2-22-g82e8dda introduced issues on some i586 systems.
>
> For example on  Fedora 19 i586:
>
>
> [  202.120451] systemd-coredump[8629]: Failed to send coredump: No
> such file or directory
> /home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/tests/ts/fdi
>sk/gpt: line 37:  8615 Aborted                 (core dumped)
> $TS_CMD_FDISK -l ${TEST_IMAGE_NAME} >> $TS_OUTPUT 2>&1
>
>         fdisk: GPT                                           ...
> FAILED (fdisk/gpt)

I've run it in gdb (last "unsigned int" fixes already applied):

 +Program received signal SIGABRT, Aborted.
 +0xf7d9502c in raise () from /lib/libc.so.6
 +#0  0xf7d9502c in raise () from /lib/libc.so.6
 +#1  0xf7d9670e in abort () from /lib/libc.so.6
 +#2  0xf7dd3ca8 in __libc_message () from /lib/libc.so.6
 +#3  0xf7dd9e43 in malloc_printerr () from /lib/libc.so.6
 +#4  0xf7dd9f20 in munmap_chunk () from /lib/libc.so.6
 +#5  0xf7f7cdd3 in fdisk_reset_labelitem (li=li@entry=0xffffd318) at libfdisk/src/item.c:75
 +#6  0xf7f820ef in fdisk_get_disklabel_item (cxt=cxt@entry=0x8065038, id=id@entry=0, item=item@entry=0xffffd318) at libfdisk/src/label.c:455
 +#7  0xf7f8233b in fdisk_get_disklabel_id (cxt=cxt@entry=0x8065038, id=id@entry=0xffffd38c) at libfdisk/src/label.c:427
 +#8  0x08052da8 in list_disk_geometry (cxt=cxt@entry=0x8065038) at disk-utils/fdisk-list.c:78
 +#9  0x08053dd0 in print_device_pt (cxt=0x8065038, device=0xffffd726 "<removed>", warnme=warnme@entry=1, verify=verify@entry=0) at disk-utils/fdisk-list.c:343
 +#10 0x0804dbdf in main (argc=3, argv=0xffffd4c4) at disk-utils/fdisk.c:951
