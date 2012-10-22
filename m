Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34590 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab2JVMp7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Oct 2012 08:45:59 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1615528lbo.19
        for <util-linux@vger.kernel.org>; Mon, 22 Oct 2012 05:45:58 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 22 Oct 2012 18:15:57 +0530
Message-ID: <CAFSEfh2myyk98cZWRU149rUAm+1e7DiAKxsUU=jBxb5ZNoLABA@mail.gmail.com>
Subject: libblkid: newbie question about enabling whole disk sysfs probe
From: Venkatraman S <venkat@linaro.org>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
 I am new to util-linux and working on adding some intelligence into
mkswap to be
aware of the underlying device properties.

I want to understand how to discover a sysfs property of a disk, when
mkswap is actually
invoked with a partition id of that disk.

If a new probe is invoked with these calls set, and mkswap is invoked
on the "whole disk" /dev/sdb

       blkdid_probe pr = new_prober(fd);
       blkid_probe_enable_superblocks(pr, 1);
       blkid_probe_enable_partitions(pr, 1);
       blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC);
       blkid_probe_enable_topology(pr, 1);

I am able to get to the property value (which is set from the sysfs
value for the disk).

But when mkswap is invokded with /dev/sdbX, then sysfs_probe is not
able to discover the parent disk's sysfs property.

Obviously it's easy to do string manipulation and invoke the probe for
the whole disk
in the latter case, I am assuming there is a library interface that'll
do the trick.
Any help would be great.

Thanks,
Venkat.
