Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755647AbdKBN0G (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Nov 2017 09:26:06 -0400
Date: Thu, 2 Nov 2017 14:26:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck.cramfs: Fix bus error on broken file system.
Message-ID: <20171102132602.uv72emiy745ql6rb@ws.net.home>
References: <20171026200117.GA14920@localhost>
 <20171027054743.GA1907@localhost>
 <20171030104357.lpl7a6vu5snvhznn@ws.net.home>
 <20171030124953.GA2109@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171030124953.GA2109@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 30, 2017 at 01:49:53PM +0100, Tobias Stoeckmann wrote:
> The utility fsck.cramfs is prone to a bus error on file systems for
> big endian systems with non-standard header sizes. While calculating
> the crc32 checksum, it does not properly handle a possible offset
> for bootcodes, resulting in out of boundary access of mmap'ed area.
> 
> You can trigger the issue with the following commands:
> 
> $ mkdir -p cramfs-poc/root/subdir
> $ cd cramfs-poc
> $ mkfs.cramfs -p -N big root cramfs
> $ echo -ne \\00\\x4c | dd of=cramfs bs=1 seek=518 count=2 conv=notrunc
> $ fsck.cramfs cramfs

Added between tests.

>  disk-utils/fsck.cramfs.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
