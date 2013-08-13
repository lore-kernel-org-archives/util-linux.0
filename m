Return-Path: util-linux-owner@vger.kernel.org
Received: from yes.iam.tj ([109.74.197.121]:46764 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756059Ab3HMAgj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Aug 2013 20:36:39 -0400
Received: from [10.254.251.50] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 8BBB53407B
	for <util-linux@vger.kernel.org>; Tue, 13 Aug 2013 01:29:13 +0100 (BST)
Message-ID: <52097DD7.2060907@iam.tj>
Date: Tue, 13 Aug 2013 01:29:11 +0100
From: TJ <linux@iam.tj>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: sfdisk: Warning: partition 5 is not contained in partition 5
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using util-linux on Ubuntu 13.04:

$ apt-cache policy util-linux | head -2
util-linux:
  Installed: 2.20.1-5.1ubuntu8

Working on a 1TB SATA drive containing a cloned image of a damaged 500GB drive recovered using ddrescue. The resulting partition table on the 1TB drive contains 4 primary partitions and only addresses
1/2 the drive, leaving the remainder inaccessible.

I thought to re-write the partition table such that partition #4 is replaced by a Linux Extended partition and partition #5 (logical) takes the values that were in primary partition #4. The problem
here is that the extended partition would start after the first logical partition and that logical partition would not be contained within the extended partition.

I realise this is generally a big no-no, but it was an intermediate step towards creating a second working clone to do repairs in. I figured out the various command-line options to make this work. I
used the "-n" dry-run option and saw the warning:

"Warning: partition 5 is not contained in partition 5"

I can't figure out, having read the source-code for sfdisk.c::partition_ok(), why 'p->ep' (assigned to 'q') is reporting the same partition as 'p'.

I've now converted the MBR to GPT using 'gdisk' but thought I'd report this odd warning message in case its an unknown subtle bug.


The intended partition table was:

$ cat partition-table.sfdisk
63,1000000,83
1000063,16601562,83
17601625,629145601,8e
976773168,976752000,85
646747226,330025942,8e



$

The command-line I used was:

$ sudo sfdisk -n -u S -O WDC_WD10EADS-partition-table.sfdisk --not-inside-outer --not-in-order --force  /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841 <partition-table.sfdisk

    Disk /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841: 121601 cylinders, 255 heads, 63 sectors/track
    Old situation:
    Units = sectors of 512 bytes, counting from 0

       Device Boot    Start       End   #sectors  Id  System
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part1            63   1000062    1000000  83  Linux
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part2       1000063  17601624   16601562  83  Linux
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part3      17601625 646747225  629145601  8e  Linux LVM
                    start: (c,h,s) expected (1023,254,63) found (71,165,56)
                    end: (c,h,s) expected (1023,254,63) found (322,38,62)
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part4     646747226 976773167  330025942  8e  Linux LVM
                    start: (c,h,s) expected (1023,254,63) found (322,38,63)
                    end: (c,h,s) expected (1023,254,63) found (385,80,63)
    Warning: bad partition start (earliest 976773169)
    New situation:
    Units = sectors of 512 bytes, counting from 0

       Device Boot    Start       End   #sectors  Id  System
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part1            63   1000062    1000000  83  Linux
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part2       1000063  17601624   16601562  83  Linux
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part3      17601625 646747225  629145601  8e  Linux LVM
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part4     976773168 1953525167  976752000  85  Linux extended
    /dev/disk/by-id/ata-WDC_WD10EADS-22M2B0_WD-WCAV5T192841-part5     646747226 976773167  330025942  8e  Linux LVM
    Warning: partition 5 is not contained in partition 5
    -n flag was given: Nothing changed


