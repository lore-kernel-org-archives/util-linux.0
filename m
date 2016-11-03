Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752466AbcKCJly (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 Nov 2016 05:41:54 -0400
Date: Thu, 3 Nov 2016 10:41:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org,
        Mike Frysinger <vapier@gentoo.org>
Subject: Re: lscpu VMWARE bdoor patch
Message-ID: <20161103094151.zufg6x2i3dth6nhe@ws.net.home>
References: <20161027102515.qw47rdgn72qingfi@ws.net.home>
 <201610280006.36584.sweet_f_a@gmx.de>
 <20161102123004.nclgs4hdnccmjzma@ws.net.home>
 <201611030804.43544.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201611030804.43544.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 03, 2016 at 09:04:42AM +0200, Ruediger Meier wrote:
> On Wednesday 02 November 2016, Karel Zak wrote:
> > On Fri, Oct 28, 2016 at 12:06:36AM +0200, Ruediger Meier wrote:
> > > On Thursday 27 October 2016, Karel Zak wrote:
> > > > Hi,
> > > >
> > > > this is lscpu output on my machine:
> > > >
> > > >     Virtualization:        VT-x
> > > >     Hypervisor vendor:     VMware
> > > >     Virtualization type:   full
> > > >
> > > >
> > > > I have nothing like VMWARE. It seem the code (commit b7744730)
> > > > does not work as expected for non-root users. What about to add
> > >
> > > Have you checked whether the original code in b7744730 is alreaday
> > > broken? Not something about the later PIC/PIE patches?
> >
> > It's Mike's PIC/PIE patch :-(
> >
> > Maybe we can ifdef more precise and add getuid() check, if I good
> > understand Mike's commit message then the problem is 32bit system.
> 
> BTW vmware runs on 64bit only since a few years. Maybe just disable 
> bdoor for 32bit if it helps to make it simple.

but you can use 32bit system (guest) inside vmware. 

I'll will add getuid() for now. Maybe someone (Mike?:-) will help us
with a better solution later.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
