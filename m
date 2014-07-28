Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25966 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbaG1MAx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 08:00:53 -0400
Date: Mon, 28 Jul 2014 14:00:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: wolput@on.nl, 756177@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: fdisk -l regression between v2.24.2 and v2.25
Message-ID: <20140728120042.GL8533@x2.net.home>
References: <53D4AA62.30501@openmailbox.org>
 <20140727104806.GA11443@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140727104806.GA11443@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 27, 2014 at 12:48:06PM +0200, Andreas Henriksson wrote:
> Hello Jos van Wolput!
> 
> Thanks for your bug report.
> 
> On Sun, Jul 27, 2014 at 03:29:38PM +0800, Jos van Wolput wrote:
> [...]
> > After upgrading util-linux 2.20.1-5.8 (sid) to version 2.25-3 (experimental) fdisk -l ends with
> > the following error: cannot open /dev/sr0: No medium found
> [...]
> > fdisk: cannot open /dev/sr0: No medium found
> > ---
> > and the other devices /dev/sdb* are not shown.
> > 
> > Indeed I don't use the cdrom (sr0) but using fdisk -l from util-linux 2.20.1-5.8 (sid) there is no such issue, all disks are shown:
> [...]
> 
> This seems to be a regression between 2.24.2 and 2.25 and git bisect tells
> me the first bad commit is: a22c6eb206fb716fa4
> 
> Reverting a22c6eb206fb716fa4 and reviving wholedisk.h from 62acb047a625059e77
> makes v2.25 fdisk -l work as expected for me.
> 
> I'm CCing the upstream developer mailing list to hopefully have some help
> on finding the proper fix.

 Already fixed in upstream tree. The patch will be in 2.25.1 (probably
 at the end of the next month).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
