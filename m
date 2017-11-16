Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933809AbdKPKu3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Nov 2017 05:50:29 -0500
Date: Thu, 16 Nov 2017 11:50:24 +0100
From: Karel Zak <kzak@redhat.com>
To: jgroves@micron.com
Cc: util-linux@vger.kernel.org, John@Groves.net
Subject: Re: [PATCH v3 0/2] libblkid: recognize Micron mpool formatted devices
Message-ID: <20171116105024.34bafpqp2lobatrg@ws.net.home>
References: <1510808499-7680-1-git-send-email-jgroves@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510808499-7680-1-git-send-email-jgroves@micron.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 15, 2017 at 11:01:37PM -0600, jgroves@micron.com wrote:
> From: John Groves <jgroves@micron.com>
> 
> This patch adds libblkid recognition of Micron mpool formatted devices.
> It also adds a very simple crc32c() function, for use by probe_mpool().
> 
> If there are objections to adding crc32c, I can re-submit without it, or
> make it static for probe_mpool(). I would prefer not to go without crc32c
> validation, because the only remaining check would be the magic number.
> 
> Review comments and/or questions still welcome.
> 
> Chages since v2:
> 
> * Remove unused char * (yes,no) constants (overlooked in v2)
> 
> Changes since v1:
> 
> * probe_mpool() no longer calls blkid_probe_set_value to set
>   VALID="yes"|"no".  This was debug code that I had failed to excise
>   previously.
> 
> Thanks,
> 
> John Groves (2):
>   Add simple crc32c() function
>   Add support for Micron mpool formatted drives

Applied, thanks!

John, it would be nice to have a regression test for mpool. It's
enough to send me gziped begin of the mpool device where is a valid
superblock (dd(1), 1000 bytes or so...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
