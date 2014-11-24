Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54822 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbaKXJX0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 04:23:26 -0500
Date: Mon, 24 Nov 2014 10:23:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Lutz Vieweg <lvml@5t9.de>, util-linux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Cc: Lukas Czerner <lczerner@redhat.com>
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
Message-ID: <20141124092313.GA926@x2.net.home>
References: <m3qnrg$5gc$1@ger.gmane.org>
 <m4f77a$ivg$1@ger.gmane.org>
 <m4nrjt$ghs$1@ger.gmane.org>
 <20141121212044.GB32316@vapier.wh0rd.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141121212044.GB32316@vapier.wh0rd.info>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 21, 2014 at 04:20:44PM -0500, Mike Frysinger wrote:
> On 21 Nov 2014 18:09, Lutz Vieweg wrote:
> > The relevant strace output of the above fstrim command:
> > > stat("/mnt/PFexp1", {st_mode=S_IFDIR|0755, st_size=6, ...}) = 0
> > > open("/mnt/PFexp1", O_RDONLY)           = 3
> > > ioctl(3, FITRIM, 0x7fff0733a4c0)        = -1 EIO (Input/output error)
> 
> that hasn't decoded the ioctl (send a patch for that), but guess is that you're 
> passing down the default:
> 	range.start = 0;
> 	range.minlen = 0;
> 	range.len = UULONG_MAX;
> 
> in which case the expectation is the kernel layers will take care of trimming 
> everything and not die when it hits the end of the device.


Yep, it's fine to specify such range, xfs_ioc_trim():

    end = start + BTOBBT(range.len) - 1;
    ...

	if (end > XFS_FSB_TO_BB(mp, mp->m_sb.sb_dblocks) - 1)
		end = XFS_FSB_TO_BB(mp, mp->m_sb.sb_dblocks)- 1;

it really seems like kernel issue. (CC: to Lukas).

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
