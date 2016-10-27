Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53460 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933375AbcJ0WHB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 27 Oct 2016 18:07:01 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: lscpu VMWARE bdoor patch
Date: Fri, 28 Oct 2016 00:06:36 +0200
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org,
        Mike Frysinger <vapier@gentoo.org>
References: <20161027102515.qw47rdgn72qingfi@ws.net.home>
In-Reply-To: <20161027102515.qw47rdgn72qingfi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610280006.36584.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 27 October 2016, Karel Zak wrote:
> Hi,
>
> this is lscpu output on my machine:
>
>     Virtualization:        VT-x
>     Hypervisor vendor:     VMware
>     Virtualization type:   full
>
>
> I have nothing like VMWARE. It seem the code (commit b7744730) does
> not work as expected for non-root users. What about to add

Have you checked whether the original code in b7744730 is alreaday 
broken? Not something about the later PIC/PIE patches?

What system are you using?

>     if (getuid() != 0)
>         return 0;
>
> to the is_vmware_platform() function?
>
>     Karel

Yes, if it's broken for a "normal" system then we have to remove that. 
Though would be nice to know what exactly made it stop working.

BTW this code is also in the kernel:
   arch/x86/kernel/cpu/vmware.c

Can't we ask the kernel about vmware somehow?


cu,
Rudi
