Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:47072 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbbE1NCr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 May 2015 09:02:47 -0400
Message-ID: <556711F5.9000109@suse.cz>
Date: Thu, 28 May 2015 15:02:45 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix /dev to /sys node name translation
References: <5565C2A8.1070505@suse.cz> <20150528104005.GB7285@ws.net.home>
In-Reply-To: <20150528104005.GB7285@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>   because the original names have been too tricky :-)
When I created the first one, I did not think that reverse will be needed.

>   I have also changed some thing in sysfs.c, it would be nice if we can
>   keep the crazy sysfs devnames (with '!') really only in sysfs specific
>   code and externally provide regular device names.
> 
>   Please, test it -- especially lsblk.

fdisk -l works, lsblk -f is broken again. lsblk worked before, but it
used '!'.


Before starting to play with '!' (687cc5d):

cciss-test:~/util-linux # ./lsblk -f
NAME           FSTYPE LABEL MOUNTPOINT
cciss!c0d0                  
├─cciss!c0d0p1              
├─cciss!c0d0p2              
└─cciss!c0d0p3              
cciss-test:~/util-linux # ./fdisk -l
cciss-test:~/util-linux # 


After 759b120: lib/sysfs: Fix /dev to /sys node name translation:
cciss-test:~/util-linux # ./lsblk -f
NAME           FSTYPE LABEL UUID                                 MOUNTPOINT
cciss!c0d0                                                       
├─cciss!c0d0p1 ext3   Boot  126055ae-08fd-4da3-a8ad-7e150d268edb /boot
├─cciss!c0d0p2 swap         e4e0d080-2b69-4ece-aeb5-e2190ad2934b [SWAP]
└─cciss!c0d0p3 btrfs        6b184ec0-512c-4620-8dc1-856a0b85969f /
cciss-test:~/util-linux # ./fdisk -l
Disk /dev/cciss/c0d0: 136.7 GiB, 146778685440 bytes, 286677120 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x0002fc74

Device            Boot   Start       End   Sectors   Size Id Type
/dev/cciss/c0d0p1 *       2048    321535    319488   156M 83 Linux
/dev/cciss/c0d0p2       321536   4530175   4208640     2G 82 Linux swap / Solaris
/dev/cciss/c0d0p3      4530176 286676991 282146816 134.6G 83 Linux
cciss-test:~/util-linux # 


HEAD d5dbd57:
cciss-test:~/util-linux # ./lsblk -f
cciss-test:~/util-linux # ./fdisk -l
Disk /dev/cciss/c0d0: 136.7 GiB, 146778685440 bytes, 286677120 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x0002fc74

Device            Boot   Start       End   Sectors   Size Id Type
/dev/cciss/c0d0p1 *       2048    321535    319488   156M 83 Linux
/dev/cciss/c0d0p2       321536   4530175   4208640     2G 82 Linux swap / Solaris
/dev/cciss/c0d0p3      4530176 286676991 282146816 134.6G 83 Linux
cciss-test:~/util-linux # 

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
