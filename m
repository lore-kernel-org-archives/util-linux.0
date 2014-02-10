Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbaBJJ5L (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Feb 2014 04:57:11 -0500
Date: Mon, 10 Feb 2014 10:57:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Michael Marineau <michael.marineau@coreos.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: add PARTTYPE tag
Message-ID: <20140210095709.GC8506@x2.net.home>
References: <1389734390-32485-1-git-send-email-michael.marineau@coreos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389734390-32485-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 14, 2014 at 01:19:49PM -0800, Michael Marineau wrote:
> Add PARTTYPE to make searching for devices partition possible without
> dropping to the low-level probe API and searching all devices by
> PART_ENTRY_TYPE. For example to find any 'EFI System Partition' devices:
> 
> $ blkid -t PARTTYPE=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> ---
>  libblkid/src/verify.c | 2 ++
>  1 file changed, 2 insertions(+)

 I think it's unnecessary (and maybe bad idea) to add a new tags to
 the high level part of the library. The high level tags have been
 introduced to support mount/fsck devices by LABEL= or UUID= tags
 (only this is reason why we have the new PARTUUID= tag there). I'd
 like to keep this layer as minimal as possible (due the problem with
 caching in blkid.tab file).
 
 If you need information about devices then use lsblk(8) rather than
 blkid(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
