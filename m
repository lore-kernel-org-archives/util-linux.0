Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55758 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbbCBT5i (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Mar 2015 14:57:38 -0500
Date: Mon, 2 Mar 2015 20:57:31 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Fedora Cloud SIG <cloud@lists.fedoraproject.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: cloud-init issues with new sfdisk
Message-ID: <20150302195731.GL8046@ws.net.home>
References: <20150302053056.GB19220@media.redhat.com>
 <54F4A3BE.1090708@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <54F4A3BE.1090708@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 02, 2015 at 05:54:06PM +0000, Pádraig Brady wrote:
> On 02/03/15 05:30, Dusty Mabe wrote:
> > 
> > The "new" sfdisk that was rewritten (see [1]) doesn't support an option that 
> > is used by growpart (which is used by cloud-init). Below is the error that occurs
> > in the TC7 compose at [2]:
> > 
> > [root@t7 ~]# growpart --dry-run /dev/vda 1                                                                                                                                                                    
> > failed [sfd_geom:1] sfdisk /dev/vda --show-pt-geometry
> > sfdisk: unrecognized option '--show-pt-geometry'
> > 
> > Does anyone know of an existing bug report for this? If not I'll write one up.
> > 
> > Dusty
> > 
> > [1] - https://github.com/karelzak/util-linux/commit/1881390de25df8587b8fc281c451796f7d032dd3#diff-31d5cc325380dbdafe64d0e019846f12R20
> > [2] - http://koji.fedoraproject.org/koji/taskinfo?taskID=9097429
> 
> You're right that that option was removed with:
> http://git.kernel.org/cgit/utils/util-linux/util-linux.git/commit/?id=v2.25-251-g1881390
> 
> Now it's a very little used option, and according to the following,
> growpart seems to be the only user.:
> http://codesearch.debian.net/results/show-pt-geometry/page_1
> 
> Karel is there an alternative that growpart could use?

 The question is why growpart need information about geometry, always
 when you need to work with geometry then you're doing something very
 wrong.

 It seems like an attempt to copy disk PT in CHS compatible way. It's 
 unnecessary. It should be enough to use --dump and then restore
 without CHS options on command line.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
