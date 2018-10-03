Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeJDEcO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 4 Oct 2018 00:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70B77308212A
        for <util-linux@vger.kernel.org>; Wed,  3 Oct 2018 21:42:04 +0000 (UTC)
Date: Wed, 3 Oct 2018 17:41:59 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Vojtech Trefny <vtrefny@redhat.com>, Karel Zak <kzak@redhat.com>
cc: Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        lvm-devel@redhat.com, util-linux@vger.kernel.org
Subject: libblkid filesystem block size
Message-ID: <alpine.LRH.2.02.1810031724070.7859@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi

As you maintain libblkid, I'd like to ask - would it be possible to add 
detection of filesystem block size to it? libblkid already has description 
of various filesystem superblocks, so it shouldn't be too hard.

LVM needs to know the block size because when it enables caching for a 
logical volume using the dm-writecache target or integrity protection 
using the dm-integrity target, the block size of the device mapper target 
should match the block size of the underlying filesystem (if the cache has 
smaller block size than the filesystem, it is inefficient, if the cache 
has larger block size than the filesystem, the filesystem won't mount).

Caching or integrity protection can be enabled on the fly for existing 
logical volumes (mounted or not mounted). XFS creates filesystems with 
512-byte block size even on some modern SSDs, so the problem with small 
block size exists even today.

Mikulas
