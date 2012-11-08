Return-Path: util-linux-owner@vger.kernel.org
Received: from g1t0028.austin.hp.com ([15.216.28.35]:18754 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab2KHPdm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 Nov 2012 10:33:42 -0500
Message-ID: <1352388340.19172.129.camel@misato.fc.hp.com>
Subject: Re: [PATCH] lscpu: Fix issue found on CPU hot-remove
From: Toshi Kani <toshi.kani@hp.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        heiko.carstens@de.ibm.com, kerolasa@iki.fi
Date: Thu, 08 Nov 2012 08:25:40 -0700
In-Reply-To: <1352349174.4728.55.camel@deadeye.wl.decadent.org.uk>
References: <1351021786-3362-1-git-send-email-toshi.kani@hp.com>
	 <20121107114714.GA29982@x2.net.home>
	 <1352330975.19172.124.camel@misato.fc.hp.com>
	 <1352349174.4728.55.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-11-08 at 04:32 +0000, Ben Hutchings wrote:
> On Wed, 2012-11-07 at 16:29 -0700, Toshi Kani wrote:
> > On Wed, 2012-11-07 at 12:47 +0100, Karel Zak wrote:
> > > On Tue, Oct 23, 2012 at 01:49:46PM -0600, Toshi Kani wrote:
> > > > 1) The system has 4 CPUs
> > > >   $ lscpu -a -e
> > > >   CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
> > > >   0   0    0      0    0:0:0      yes
> > > >   1   0    1      1    1:1:1      yes
> > > >   2   0    2      2    2:2:2      yes
> > > >   3   0    3      3    3:3:3      yes
> > > > 
> > > > 2) Eject cpu2
> > > >   # echo 1 > /sys/bus/acpi/devices/LNXCPU:02/eject
> > > > 
> > > > 3) lscpu no longer recognizes cpu3 after cpu2 is ejected
> > > >   $ lscpu -a -e
> > > >   CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
> > > >   0   0    0      0    0:0:0      yes
> > > >   1   0    1      1    1:1:1      yes
> > > > 
> > > > The following changes are made to address this issue.
> > > >  - Use maxcpus to allocate and parse bitmaps.
> > > >  - Set desc->ncpu from cpu/present, which includes both on-line
> > > >    and off-line CPUs.
> > > 
> > >  In the directory tests we have a dump from some strange machine
> > > 
> > >     tests/ts/lscpu/dumps/sparc64-UltraSparc-T1.tar.gz
> > > 
> > >  where is 32 /sys/devices/system/cpu/cpu[0-9]* subdirectories, but the
> > >  present mask is 0-23, all the masks from the dump:
> > > 
> > >  present: 0-23
> > >  possible: 0-31
> > >  online: 0-23
> > >  offline: 24-31
> > >  count: 32      (means ls -d sys/devices/system/cpu/cpu[0-9]* | wc -l)
> > > 
> > >  strange, right? But I guess we can ignore this dump, according to
> > >  kernel Documentation/cpu-hotplug.txt the cpu[0-9]* subdirectories
> > >  have to follow the present mask. Maybe the dump is broken or so..
> > 
> > Hi Karel,
> > 
> > Thanks for the updated patch.  It looks good.  I have tested it on my
> > setup and it worked fine as well.
> > 
> > I agree that the present mask and cpu directories need to be consistent.
> > I looked at the kernel code and found the following change, which might
> > be the cause of this issue.
> > 
> > ====
> > commit 9f13a1fd452f11c18004ba2422a6384b424ec8a9
> > Author: Ben Hutchings <ben@decadent.org.uk>
> > Date:   Tue Jan 10 03:04:32 2012 +0000
> > 
> >     cpu: Register a generic CPU device on architectures that currently
> > do not
> >     
> >     frv, h8300, m68k, microblaze, openrisc, score, um and xtensa
> > currently
> >     do not register a CPU device.  Add the config option
> > GENERIC_CPU_DEVICES
> >     which causes a generic CPU device to be registered for each present
> > CPU,
> >     and make all these architectures select it.
> >     
> >     Richard Weinberger <richard@nod.at> covered UML and suggested using
> >     per_cpu.
> >     
> >     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > ====
> > 
> > 
> > Hi Ben,
> > 
> > In the change log above, you described that a generic CPU device to be
> > registered for each "present" CPU.  However, in the code below, it used
> > for_each_possible_cpu(), instead of for_each_present_cpu().  Is this
> > what you intended?
> [...]
> 
> I think the distinction doesn't matter - the GENERIC_CPU_DEVICES code
> does not support hotplug and therefore can only be used if present ==
> possible.

Hi Ben,

You may be right about that on those architectures where you added
GENERIC_CPU_DEVICES.  We have seen strange cpu directories on Sparc64,
but it does not seem to use the GENERIC_CPU_DEVICES code.  So, this
issue may not be related with your change.  Sorry about that.

Thanks,
-Toshi


> Ben.
> 


