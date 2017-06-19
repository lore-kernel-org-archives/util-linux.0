Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdFSO5H (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 10:57:07 -0400
Date: Mon, 19 Jun 2017 16:56:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Istvan Gabor <suseuser04@gmail.hu>
Cc: util-linux@vger.kernel.org
Subject: Re: adding new logical partition in cfdisk
Message-ID: <20170619145657.4mc6blkjsb7ltkw6@ws.net.home>
References: <a1a3d4f7ce3c9cc861d96feb4f9f85e7@gmail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1a3d4f7ce3c9cc861d96feb4f9f85e7@gmail.hu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 07:37:35PM +0200, Istvan Gabor wrote:
> Currently I have version 2.28 which comes
> with default openSUSE Leap 42.2.
> 
> This version doesn't show volume labels
> and it doesn't indicate the file systems
> on the partitions (eg ext3, ext4).

There is a info box with extra information. It should be enabled by
default (or possible to toggle by 'x').

> I would like to add a new logical partition to the
> free space. I select/highlight free space, then select
> "New".

You need free space within the extended partition to create another
logical partition. 

Unfortunately, the current cfdisk does not support any resize
operation. And the current stable  libfdisk does not support extended
partition resize at all ;-(

The libfdisk limitation is already fixed in the git tree, and I'd like to 
improve cfdisk for v2.31 too.

So there is no elegant way to use the free space behind the
extended partition, but there is usable workaround:

* dump your partition table by sfdisk and create a copy

  # sfdisk --dump /dev/sdd > old-mbr
  # cp old-mbr new-mbr

* see free spaces:

  sfdisk --list-free /dev/sdd

* modify the new-mbr (text file and change size
  of the partition sdd4 (your extended partition) to 
  
    current_size + freespace_size

  for your sdd it should be 

   190550817  (= 179670960 + 10879857)

 * save the file and *try* use it to re-create the partition table

  sfdisk --no-act --no-reread /dev/sdd < new-mbr
         ^^^^^^^^

 * if all seems OK then do it without "--no-act"


 You can revert all by
    sfdisk --no-reread /dev/sdd < old-mbr


 I hope for v2.30.1 it's will be possible to enlarge logical and
 extended partition by sfdisk and for v2.31 also by cfdisk.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
