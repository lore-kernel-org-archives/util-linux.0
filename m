Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53012 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757223AbbDPLv3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Apr 2015 07:51:29 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Thomas Bechtold <tbechtold@suse.com>
Subject: Re: sfdisk input parsing broken with 2.26.1
Date: Thu, 16 Apr 2015 13:51:22 +0200
Cc: util-linux@vger.kernel.org
References: <552F87E5.5010507@suse.com>
In-Reply-To: <552F87E5.5010507@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201504161351.23675.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 16 April 2015, Thomas Bechtold wrote:
> [please CC me - I'm not subscribed to the list]
>
> Hi,
>
> the following worked fine with 2.20 (tested on Ubuntu):
>
> sfdisk $IMAGE_BLOCK_DEVICE << EOF
> 1 - - *
> 0 0;
> 0 0;
> 0 0;
> EOF


BTW I've noticed that since 2.26 --dump produces incompatible dump 
files. Shouldn't we have at least backward compatibility, i.e. old 
dumps still work with new sfdisk?

If you dump the above example with sfdisk 2.23.2 then 2.26 cant't use 
it.

## Dump with old sfdisk:

$ sfdisk -d /tmp/image > /tmp/p1
$ cat /tmp/p1
# partition table of /tmp/image
unit: sectors

/tmp/image1 : start=    16065, size=209696445, Id=83, bootable
/tmp/image2 : start=        0, size=        0, Id= 0
/tmp/image3 : start=        0, size=        0, Id= 0
/tmp/image4 : start=        0, size=        0, Id= 0
----------------

## Write back with new sfdisk:

$ ./sfdisk /tmp/image < /tmp/p1
Checking that no-one is using this disk right now ... OK

Disk /tmp/image: 100 GiB, 107374182400 bytes, 209715200 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Old situation:

Device      Boot Start       End   Sectors  Size Id Type
/tmp/image1 *    16065 209712509 209696445  100G 83 Linux

>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xdf10c8b1.
Created a new partition 1 of type 'Linux' and of size 100 GiB.
Start sector 0 out of range.
Failed to add partition: Numerical result out of range
/tmp/image2: Leaving.
-------------

cu,
Rudi
