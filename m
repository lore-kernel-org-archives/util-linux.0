Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752441AbcKBMaG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Nov 2016 08:30:06 -0400
Date: Wed, 2 Nov 2016 13:30:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org,
        Mike Frysinger <vapier@gentoo.org>
Subject: Re: lscpu VMWARE bdoor patch
Message-ID: <20161102123004.nclgs4hdnccmjzma@ws.net.home>
References: <20161027102515.qw47rdgn72qingfi@ws.net.home>
 <201610280006.36584.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610280006.36584.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 28, 2016 at 12:06:36AM +0200, Ruediger Meier wrote:
> On Thursday 27 October 2016, Karel Zak wrote:
> > Hi,
> >
> > this is lscpu output on my machine:
> >
> >     Virtualization:        VT-x
> >     Hypervisor vendor:     VMware
> >     Virtualization type:   full
> >
> >
> > I have nothing like VMWARE. It seem the code (commit b7744730) does
> > not work as expected for non-root users. What about to add
> 
> Have you checked whether the original code in b7744730 is alreaday 
> broken? Not something about the later PIC/PIE patches?

It's Mike's PIC/PIE patch :-(

Maybe we can ifdef more precise and add getuid() check, if I good
understand Mike's commit message then the problem is 32bit system.

> What system are you using?

Fedora 24

# uname -a
Linux ws 4.7.7-200.fc24.x86_64 #1 SMP Sat Oct 8 00:21:59 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

> >     if (getuid() != 0)
> >         return 0;
> >
> > to the is_vmware_platform() function?
> >
> >     Karel
> 
> Yes, if it's broken for a "normal" system then we have to remove that. 
> Though would be nice to know what exactly made it stop working.
> 
> BTW this code is also in the kernel:
>    arch/x86/kernel/cpu/vmware.c
> 
> Can't we ask the kernel about vmware somehow?

There is something for 390 and Xen, but I don't see in kernel code
hypervisor_kobj (or something else) for VMware.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
