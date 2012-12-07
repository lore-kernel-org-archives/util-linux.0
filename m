Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:36327 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100Ab2LGRZK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Dec 2012 12:25:10 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 45DF3A5206
	for <util-linux@vger.kernel.org>; Fri,  7 Dec 2012 18:25:09 +0100 (CET)
Date: Fri, 7 Dec 2012 18:25:06 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH 4/5] sulogin: mount temporary /dev and /proc
 if not found
Message-ID: <20121207172506.GA27066@boole.suse.de>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
 <1354867258-14206-4-git-send-email-werner@suse.de>
 <20121207141709.GF603@rampage>
 <20121207154917.GA24191@boole.suse.de>
 <20121207170118.GG603@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121207170118.GG603@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 12:01:18PM -0500, Dave Reisner wrote:
> 
> Ok, I didn't realize udev still was responsible for these links these
> days, but perusing the code shows otherwise. Could you explain why
> sulogin is wanted in the initramfs? Seems like an odd use case to me.
> 
> > If in initrd the sulogin will be called after mounting /proc and /dev and running
> > udev rules or enabling the links in initrd then the code does only check for existence
> > of /proc and /dev.
> 
> If you're in the initramfs, rootfs is tmpfs. Won't your statfs check
> return a buffer which has f_type == TMPFS_MAGIC even if /dev is not
> mounted?

Hmmm ... maybe a check for RAMFS_MAGIC should be done before to
distinguish between TMPFS_MAGIC or RAMFS_MAGIC for the initrd.
Or the mounted /proc could be used to check for /dev

    Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
