Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914Ab2JVO2R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 10:28:17 -0400
Date: Mon, 22 Oct 2012 16:28:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Venkatraman S <venkat@linaro.org>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: newbie question about enabling whole disk sysfs probe
Message-ID: <20121022142813.GD21724@x2.net.home>
References: <CAFSEfh2myyk98cZWRU149rUAm+1e7DiAKxsUU=jBxb5ZNoLABA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFSEfh2myyk98cZWRU149rUAm+1e7DiAKxsUU=jBxb5ZNoLABA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 22, 2012 at 06:15:57PM +0530, Venkatraman S wrote:
>        blkid_probe_enable_topology(pr, 1);

This is strings based interface (NAME=value). It's probably
better to use:

   tp = blkid_probe_get_topology(pr);

   blkid_topology_get_alignment_offset(tp);

see libblkid/samples/topology.c.


> I am able to get to the property value (which is set from the sysfs
> value for the disk).
> 
> But when mkswap is invokded with /dev/sdbX, then sysfs_probe is not
> able to discover the parent disk's sysfs property.

Really? It should be able to translate the partition name to the
whole-disk name and us it.

# ./sample-topology /dev/sdd1
----- binary interface:
	alignment offset     : 0
	minimum io size      : 4096
	optimal io size      : 262144
	logical sector size  : 4096
	physical sector size : 4096
----- NAME=value interface (values: 4):
	MINIMUM_IO_SIZE = 4096
	OPTIMAL_IO_SIZE = 262144
	PHYSICAL_SECTOR_SIZE = 4096
	LOGICAL_SECTOR_SIZE = 4096



> Any help would be great.

 What exactly is your goal?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
