Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:53296 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbcKCHFN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 Nov 2016 03:05:13 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: lscpu VMWARE bdoor patch
Date: Thu, 3 Nov 2016 09:04:42 +0200
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org,
        Mike Frysinger <vapier@gentoo.org>
References: <20161027102515.qw47rdgn72qingfi@ws.net.home> <201610280006.36584.sweet_f_a@gmx.de> <20161102123004.nclgs4hdnccmjzma@ws.net.home>
In-Reply-To: <20161102123004.nclgs4hdnccmjzma@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201611030804.43544.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 02 November 2016, Karel Zak wrote:
> On Fri, Oct 28, 2016 at 12:06:36AM +0200, Ruediger Meier wrote:
> > On Thursday 27 October 2016, Karel Zak wrote:
> > > Hi,
> > >
> > > this is lscpu output on my machine:
> > >
> > >     Virtualization:        VT-x
> > >     Hypervisor vendor:     VMware
> > >     Virtualization type:   full
> > >
> > >
> > > I have nothing like VMWARE. It seem the code (commit b7744730)
> > > does not work as expected for non-root users. What about to add
> >
> > Have you checked whether the original code in b7744730 is alreaday
> > broken? Not something about the later PIC/PIE patches?
>
> It's Mike's PIC/PIE patch :-(
>
> Maybe we can ifdef more precise and add getuid() check, if I good
> understand Mike's commit message then the problem is 32bit system.

BTW vmware runs on 64bit only since a few years. Maybe just disable 
bdoor for 32bit if it helps to make it simple.

> > What system are you using?
>
> Fedora 24
>
> # uname -a
> Linux ws 4.7.7-200.fc24.x86_64 #1 SMP Sat Oct 8 00:21:59 UTC 2016
> x86_64 x86_64 x86_64 GNU/Linux
>
> > >     if (getuid() != 0)
> > >         return 0;
> > >
> > > to the is_vmware_platform() function?
> > >
> > >     Karel
> >
> > Yes, if it's broken for a "normal" system then we have to remove
> > that. Though would be nice to know what exactly made it stop
> > working.
> >
> > BTW this code is also in the kernel:
> >    arch/x86/kernel/cpu/vmware.c
> >
> > Can't we ask the kernel about vmware somehow?
>
> There is something for 390 and Xen, but I don't see in kernel code
> hypervisor_kobj (or something else) for VMware.
>
>     Karel


