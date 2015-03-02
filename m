Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbbCBUNR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Mar 2015 15:13:17 -0500
Date: Mon, 2 Mar 2015 21:13:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: sfdisk problem with a partition starting early on a GPT disk
Message-ID: <20150302201311.GM8046@ws.net.home>
References: <20150301155610.GW3933@cordes.ca>
 <20150302100652.GI8046@ws.net.home>
 <20150302161932.GX3933@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302161932.GX3933@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 02, 2015 at 12:19:32PM -0400, Peter Cordes wrote:
>  If libfdisk doesn't actually store anything after sector 33, it would
> be nice if it wrote a GPT to disk that that has sector 34 as the
> first-usable. 

 I'm not sure, the common consensus is to use 1MiB offset for the
 first partition -- then it does not make sense to define
 FirstUsableLBA smaller, because the extra space between the first
 partition may be interpreted as gap and later (inadvertently)
 partitioned.

 Note the I'm talking about default layout, your example with 
 --dump and restore is different -- sfdisk has to be able to 
 copy existing partition tables.
 
 BTW, the problem should be fixed in git tree, you have to --dump with
 new sfdisk and then it will add "first-lba" number to scrit header.
 You can also use 

  label: gpt
  first-lba: 34

 lines to manually create a GPT header by sfdisk.

> That way, I could use gdisk to add a boot partition on
> each disk after copying the layout of the other partitions with
> sfdisk.  (That would be a minimal fix that isn't as nice as actually
> supporting copying arbitrary valid GPT partition tables.  But it

 It would be better to learn partitioning tools to modify
 FirstUsableLBA in GPT header. I'll probably implement it for v2.27
 fdisk, so creative users like you will be able to tune up their
 partition tables :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
