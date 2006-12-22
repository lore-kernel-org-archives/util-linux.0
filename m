Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946021AbWLVKYO (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 05:24:14 -0500
Date: Fri, 22 Dec 2006 11:24:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Bryan Henderson <bryanh@giraffe-data.com>, ethanol@armory.com, ams@gnu.org,
        P@draigbrady.com, util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222102404.GU5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 22, 2006 at 01:12:54AM -0500, Albert Cahalan wrote:
> On 12/21/06, Karel Zak <kzak@redhat.com> wrote:
> 
> >> problem, since there are people who are willing to maintain some
> >> pieces, but less energetic about maintaining the entire package or
> >> working through a central bureaucracy.
> >
> > I don't see any problem collaborate with more people.
> 
> Power sharing is difficult.

 Oh.. yes. Good things are difficult :-)

> I see rdev. If I remember right, that's used for the pre-2.6 kernels

 I'm not 100% if wee still need it, but RH and Suse still have
 rdev for ix86. 
 
 rdev = ramsize, rootflags and vidmode (all is implemented in rdev.c)

> Lots of computers don't even have floppy drives anymore.

 and a lot of computers still have floppy drives...

> arch -- OK, though people use uname

 we have tried remove it from FC, but many users still use it.

> chkdupexe -- OK, though obscure

 removed from in FC/RHEL, included in Suse and Debian

> ddate -- pure junk

 yes, strange tool

> line -- people use read

 removed from in FC/RHEL, included in Suse and Debian

> namei -- OK, though obscure and probably broken

 I have patches for this tool. I've played with it last week and
 it's not so bad tool. For example list all permission for a path: 

 namei -m /usr/local/bin/cvscheck 
 f: /usr/local/bin/cvscheck
   drwxr-xr-x /
   drwxr-xr-x usr
   drwxr-xr-x local
   drwxr-xr-x bin
   -rwxr-xr-x cvscheck

 I don't think it's so easily possible with an other tool.

> pg -- old-timers from SysV are probably addicted

 removed from FC/RHEL and Suse, included in Debian

> whereis -- might make sense on Gentoo or BSD

 I often use it :-)

> cytune -- very obsolete hardware?

 ix86 alpha armv4l

> elvtune -- useful

 removed from FC/RHEL, included in Suse, Debian

 elvtune is only useful on older kernels, 2.6 use IO scheduler and
 sysfs tunables. So deprecated tool.

> fdformat -- for nostalgia?

 No, I have feedback that people use it. FC/RHEL also includes
 http://floppyutil.sourceforge.net/ that supports IDE floppies too.

> fsck.minix -- for the retro-computing crowd

 removed from FC/RHEL, included in Suse, Debian

> getty -- might get used on servers for serial consoles (*)

 agetty

> isosize -- belongs with mkisofs, not in util-linux

 probably yes

> mkfs.minix -- for the retro-computing crowd

 removed from FC/RHEL, included in Suse, Debian

> raw -- obsolete

 Still supported by kernel. We have to keep it in the package.

 (My idea has been remove it from RHEL5, but there is
 still many enterprise users who require it. Things are moving
 slowly...)

> tunelp -- obsolete (new PCs even lack the ports)

 Really? My one week old dell has it.


 There is more odd utils:

 newgrp     - broken, there is better version in shadow-utils 

 (but the version in shadow-utils is broken too. I fixed it one year
 ago, but the patch is in FC/RHEL only :-( Need discussion with
 shadow-utils upstream.


 sln    - removed from FC/RHEL and Debian, included in Suse
        (new version is in glibc)

 shutdown   - removed from all dists (new version for example in
              SysVinit)


 wall - included in Suse (new version in SysVinit)

 scriptreplay  - Perl script ;-( I'm going to rewrite to C. The
            dependence on Perl is ugly for basic system package.
       
 last   - probably removed from all dists (new version in SysVinit)
 

 I think we can mark many of these utils as deprecated in 2.13 release
 and remove it in a future release (2.14). Maybe we can do
 something like

     ./configure --deprecated="list of wanted deprecated utils"

 it means default installation will be without these tools and 
 nostalgic uses will be compile with the --deprecated option.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
