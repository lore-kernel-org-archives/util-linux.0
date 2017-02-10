Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbdBJKHu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Feb 2017 05:07:50 -0500
Date: Fri, 10 Feb 2017 10:59:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, util-linux@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
Message-ID: <20170210095953.dncpkyaltfa3kj36@ws.net.home>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
 <20170209123603.oi763dhsfvxhsv6m@ws.net.home>
 <96cd8646-d971-4e25-f97c-a1c782016573@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <96cd8646-d971-4e25-f97c-a1c782016573@wdc.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 10, 2017 at 12:06:58PM +0900, Damien Le Moal wrote:
> Karel, Shaun,
> 
> Tested on SAS and SATA host-managed drive. No problems detected.
> A few remarks though:
> 
> 1) The term "lba" is being used throughout (command description and
> error messages). This is confusing when using 4K drives. Since in fact
> the unit used for the arguments and displayed results is the traditional
> 512B "sector", I think that "LBA" should be replaced by "sector" is all
> messages, command argument descriptions and man pages.

 Fixed.

> 2) In kernel, the offset passed to the zone reset ioctl is indeed
> checked for alignment to the drive LBA size. So checking the offset
> passed to blkreset makes sense. However, the same check for report is a
> little too harsh since the kernel will accept an unaligned sector number
> (it will be aligned down to the containing zone start sector before
> issuing a report zones command to the drive). So we could get rid of
> that check I think.

Fixed.

> Otherwise, please feel free to add:
> Tested-by: Damien Le Moal <damien.lemoal@wdc.com>

Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
