Return-Path: dave@gnu.org
Subject: RE: eject on Cygwin?
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A0B9@MCHP058A.global-ad.net>
References: 
	 <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A097@MCHP058A.global-ad.net>
	 <20120423094420.GA8144@x2.net.home>
	 <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A0B9@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Apr 2012 12:25:00 +0200
Message-ID: <1335176700.2556.12.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-04-23 at 11:49 +0200, Voelker, Bernhard wrote:
> Karel Zak wrote:
> 
> > On Mon, Apr 23, 2012 at 11:31:11AM +0200, Voelker, Bernhard wrote:
> > > Is there a specific reason for this line in configure.ac?
> > >   UL_REQUIRES_LINUX([eject])
> > > 
> > > Can't Cygwin handle /dev/scd0 correctly? 
> > 
> >  I don't know, the code also depends on /sys to detect if the device
> >  is removable, it calls umount(2) syscall, etc.
> 
> okay, thanks.
> Anyway, porting u-l to cygwin is not much fun anymore,
> e.g. due to new close_stdout() which needs __fpending, and
> lib/randutils.c needs sys/syscall.h to check if __NR_gettid
> is defined etc.

Plus, like eject, most tools use a lot of sysfs and procfs files, which
are pretty Linux-specific.

> 
> Have a nice day,
> Berny
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
