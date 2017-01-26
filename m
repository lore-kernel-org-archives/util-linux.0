Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdAZM5W (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 26 Jan 2017 07:57:22 -0500
Date: Thu, 26 Jan 2017 13:57:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/1] fstrim: de-duplication of btrfs subvolumes
Message-ID: <20170126125720.3ufyk75ujxqkscqd@x2.net.home>
References: <bebe5a12-6927-b602-22ea-ea8e62b7f4ce@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bebe5a12-6927-b602-22ea-ea8e62b7f4ce@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 25, 2017 at 06:30:11PM +0100, Stanislav Brabec wrote:
> I got a report that TRIM is called many times on btrfs with subvolumes.
> I did a research and found that sys-utils/fstrim.c: uniq_fs_source_cmp()
> contains a code that compares not only file system sources (i. e.
> devices), but also roots.
> 
> I doubt that it is needed in any situation. We just care about source,
> i. e. device node. I think that if it matches, it is always particular
> device duplicate.
> 
> Root does not equal for btrfs subvolumes, but also it does not equal for
> bind mounts. And btrfs subvolumes remain duplicated after the whole
> de-duplication process.

Ah... I have probably thought the roots are really independent on the
device, but now when I think about it the idea does not make sense :-)

> The patch assumes that the root comparison is not needed here at all. If
> it is not true, I will prepare another patch ignoring root specifically
> for btrfs.

The patch makes more sense than the original code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
