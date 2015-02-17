Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46977 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbbBQK3u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Feb 2015 05:29:50 -0500
Received: by lbjf15 with SMTP id f15so3540713lbj.13
        for <util-linux@vger.kernel.org>; Tue, 17 Feb 2015 02:29:48 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 17 Feb 2015 10:29:48 +0000
Message-ID: <CAMU1PDiQ77gmLQa1cDq17TDxv6wZ=uK3et-_eZ0ZCMJ89FT3=Q@mail.gmail.com>
Subject: wipefs no longer shows or erases nilfs2 signatures
From: Mike Fleetwood <mike.fleetwood@googlemail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

wipefs is no longer able to show and erase nilfs2 file system
signatures.  Bisected this to commit:
    5f77ce6 libblkid: (nilfs2) check also backup superblock

Test case on Fedora 21:

# mkfs.nilfs2 /dev/sdb1
# wipefs -V
wipefs from util-linux 2.25.2
# wipefs /dev/sdb1
# wipefs -a /dev/sdb1

Test case on CentOS 7:

# mkfs.nilfs2 /dev/sdb1
# wipefs -V
wipefs from util-linux 2.23.2
# wipefs /dev/sdb1
offset               type
-----------------------------------------------------------------
0x406                nilfs2   [filesystem]
                     UUID:   74b7210c-f568-404f-b302-db0e0339182d
# wipefs -a /dev/sdb1
/dev/sdb1: 2 bytes were erased at offset 0x00000406 (nilfs2): 34 34


So commit 5f77ce6 looks to be about reading either the primary or backup
super block with the highest sequence/checkpoint number.  However with a
probe function and no magics wipefs isn't able to detect the file system
or clear the signature bytes.

Re-adding this to libblkid/src/superblocks/nilfs2.c:
        .magics = { { .magic="\x34\x34", .len=2, .kboff=1, .sboff=6},
                    { NULL }
                  }
makes wipefs work, but as far as I can tell causes libblkid to use it in
preference to the probefunc so libblkid stops using the backup super
block as a way to identify a nilfs2 file system.  Also adding this
doesn't get the signature bytes in the backup super block erased.
Didn't seem to be a way to specify the second magic as being relative to
rounded 4K from the end of the partition.

Hope this analysis is correct.  I didn't see a trivial fix so I need to
leave it to the experts.

Thanks,
Mike
