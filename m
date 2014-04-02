Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63725 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030403AbaDBVyK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 17:54:10 -0400
Received: from brln-4db84a2f.pool.mediaways.net ([77.184.74.47]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MP1PX-1WQnsl3sDn-006MS6
 for <util-linux@vger.kernel.org>; Wed, 02 Apr 2014 23:54:09 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: fdisk partition reorder fails
Date: Wed, 2 Apr 2014 23:54:05 +0200
References: <20140402164925.GA13910@aepfle.de> <533C4911.4020406@yahoo.com.ar>
In-Reply-To: <533C4911.4020406@yahoo.com.ar>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201404022354.05958.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 02 April 2014, Gerardo Exequiel Pozzi wrote:
> Looks like similar to this[#1] that I reported some time ago.
>
> [#1] http://www.spinics.net/lists/util-linux-ng/msg08005.html

I've translated Gerardo's example into a reproducable command lines. Do 
this only on filesystems which support sparse files. Here I've skipped 
any output for readability:

## create a partition table with a "hole" between partition 5 and 6
$ rm -f testdisk
$ truncate -s 2199023255552  testdisk
$ sfdisk testdisk  <<EOF
unit: sectors
testdisk1 : start=     2048, size=   131072, Id=83
testdisk2 : start=   133120, size= 41943040, Id=83
testdisk3 : start= 42076160, size= 41943040, Id=83
testdisk4 : start= 84019200, size=3823009968, Id= 5
testdisk5 : start= 84021248, size=  8388608, Id=83
testdisk6 : start=125974528, size=1258291200, Id=83
testdisk7 : start=1384267776, size=2097152000, Id=83
testdisk8 : start=3481421824, size=425607344, Id=83
EOF
[... output skipped ...]


## add another partition and print before and after sorting (don't
## write, so this line can be used repeatedly)
$ echo -e "n\n\n\np\nx\nf\nr\np\n" | fdisk testdisk
[... output skipped ...]


## See that fdisk is not even able to write the partitions correctly
## after adding the 9th partition without sorting. Maybe this is part
## of the bug
$ echo -e "n\n\n\np\nw\n" | fdisk testdisk
$ fdisk -l testdisk

cu,
Rudi
