Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708AbcDRK7Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 06:59:25 -0400
Date: Mon, 18 Apr 2016 12:59:23 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC][WIP][PATCH] fsck -l and lvm/dmcrypt/md/etc
Message-ID: <20160418105923.lj5sb2m4joxxehno@ws.net.home>
References: <m34mbbrd8d.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m34mbbrd8d.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 09, 2016 at 12:40:18AM +0300, Yuriy M. Kaminskiy wrote:
> I think this algorithm should work:
> 
> 1) walk /dev/block/${dev}/slaves recursively (e.g. lvm-over- luks-
> over-lvm- over-md, first-level slaves won't work), collect all
> whole-disk devices;
> 2) sort this list by device numbers (to avoid AB/BA deadlocks), remove
> duplicates;
> 3) acquire all locks consequently.
> 
> There are some unavoidable flaws (e.g. if someone alters structure while fsck
> is running), and some things could be improved, but it should work in
> most cases (and if it fails, it is just no worse than current behavior).
> 
> I've tested with LVM and LUKS-over-LVM on (debian's) 3.16 kernel, it seems
> works as expected.
> 
> What is not covered: /dev/loop* (and I have no plans for it).
> 
> Comments? NACKs?

The question is if we really need it :-) 

All the care fsck has about whole-disks is about performance, because
we assume (on classic rotation disks) that execute fsck on more
partitions in the same time is bad idea.

The problem with stacked devices is that we have no clue about sectors
mapping. Your patch locks all the disks, but maybe kernel will read
only from some subset of the disks, etc. 

>From my point of view the best way is not to care about it in
userspace at all and depend on kernel I/O scheduling only. The
optimization probably still makes sense for classic layout
"HDD->partition", but I don't think we need to extend this
functionality to another use-cases.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
