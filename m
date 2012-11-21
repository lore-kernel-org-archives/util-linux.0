Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871Ab2KUOxy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Nov 2012 09:53:54 -0500
Date: Wed, 21 Nov 2012 15:53:50 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, grawity@gmail.com
Subject: Re: [bug] incorrect GPT entry validation?
Message-ID: <20121121145350.GA2912@x2.net.home>
References: <20121103183511.GO482@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121103183511.GO482@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 03, 2012 at 02:35:11PM -0400, Dave Reisner wrote:
> blkid correctly reads the first 2 entries on the disk, but then starts
> reporting corrupted GPT entries (seen via LIBBLKID_DEBUG=0xffff):

 We have two GPT headers... and the third pass have nothing
 to parse :-)

 This is the bug:

          swap_efi_guid(&e->unique_partition_guid);
          swap_efi_guid(&e->partition_type_guid);

 the "e" is persistent buffer.

 Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
