Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.dds.nl ([83.96.147.103]:32814 "EHLO smtp2.dds.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755006AbcHSChX (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
        Thu, 18 Aug 2016 22:37:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 18 Aug 2016 22:39:30 +0200
From: Xen <list@xenhideout.nl>
To: util-linux-ng@vger.kernel.org
Cc: util-linux@vger.kernel.org
Subject: PV on disk without partitions not recognised as LVM2_member
Message-ID: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I am not getting a majordomo response (as usual, I guess, within a 
reasonable amount of time :p) to subscribe to this list, but....



Perchance,

Would someone be will to fix the issue that a Physical Volume from LVM2 
(PV) when placed directly on disk (no partitions or partition tables) 
will not be recognised as LVM2_member but rather as something else, such 
as "dos" (if nothing else is found) or e.g. some RAID device (if a RAID 
signature exists at the end of the device.

Ie. I had a disk that had a "promise fasttrack raid member" (from 
memory) signature at the end of the disk (last 1MB) and was recognised 
as such. When I wiped the signature, it was recognised as "dos":

/dev/sda: PTUUID="ef39c6e5" PTTYPE="dos"


pvck /dev/sda:

   Found label on /dev/sda, sector 1, type=LVM2 001
   Found text metadata area: offset=4096, size=1044480


The LVM2 udev rules for lvm-metad depend on blkid currently to report 
the nature of a block device such that they can know whether to activate 
it; as such a PV directly on disk will not get activated by udev rules.

Will also not get scanned, the whole pvscan --cache --activate ay 
command will not get executed.

It seems it would be best to solve it at the root of the issue rather 
than changing LVM's udev scripts.

Regards.
