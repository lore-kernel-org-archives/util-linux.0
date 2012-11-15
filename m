Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536Ab2KOHxC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Nov 2012 02:53:02 -0500
Date: Thu, 15 Nov 2012 08:52:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: util-linux@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Petr Pisar <ppisar@redhat.com>
Subject: Re: vlock command
Message-ID: <20121115075253.GA26255@x2.net.home>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
 <20121114122610.GF1835@x2.net.home>
 <20121114233117.GD20303@altlinux.org>
 <50A48F5F.3090404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50A48F5F.3090404@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 15, 2012 at 10:44:47AM +0400, Alexey Gladkov wrote:
> 15.11.2012 03:31, Dmitry V. Levin wrote:
> > On Wed, Nov 14, 2012 at 01:26:10PM +0100, Karel Zak wrote:
> >
> >>  Alexey, just today I added --erase option to Fedora version. Maybe
> >>  you can apply the patch below to your repository too. Author of the
> >>  patch is Petr Pisar <ppisar@redhat.com>.
> > 
> > The first vlock RFE for ages!  Alexey, please apply.
> 
> Dmitry, I mistakenly did not add you in the Cc. I wrote Karel that
> similar functionality you have already implemented.
> Here is my answer:
> 
> > On closer look I found out that the my version of vlock already erases
> > display if we are on the virtual console:
> > 
> > http://git.altlinux.org/people/legion/packages/kbd.git?p=kbd.git;a=blob;f=src/vlock/screen.c;h=720d880080f9030553a32d625756b5e30c6d4266;hb=768b8c314e1d3c465d895b206da4aa4543914d1d#l37
> > 
> > http://git.altlinux.org/people/legion/packages/kbd.git?p=kbd.git;a=blob;f=src/vlock/vt.c;h=50746de238f5acc231d2ffef8a5604dfbef3cfad;hb=768b8c314e1d3c465d895b206da4aa4543914d1d#l194
> > 
> > As I understand you want a similar functionality. Is this enough for
> > you, or you want to be able to clear the display regardless of conditions?

 CC: to Petr, original author of the patch.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
