Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35532 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764AbbCQTZ7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 15:25:59 -0400
Date: Tue, 17 Mar 2015 20:25:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: question about findmnt --target
Message-ID: <20150317192552.GY28925@ws.net.home>
References: <201503171608.58423.sweet_f_a@gmx.de>
 <20150317163426.GW28925@ws.net.home>
 <201503171814.00580.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503171814.00580.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 17, 2015 at 06:14:00PM +0100, Ruediger Meier wrote:
> On Tuesday 17 March 2015, Karel Zak wrote:
> > On Tue, Mar 17, 2015 at 04:08:58PM +0100, Ruediger Meier wrote:
> > > Hi,
> > >
> > > I wonder what is the correct way to find a mount which is mounted
> > > to a certain target directory. findmnt --target will also find a
> > > mount if you specify a subdirectory of a mountpoint:
> > >
> > > $ mkdir /tmp/bla
> > > $ findmnt --target /tmp/bla
> > > TARGET SOURCE                        FSTYPE OPTIONS
> > > /tmp   /dev/mapper/vg0-tmpdirs[/tmp] ext4 ....
> > >
> > > The man page let me think that --target should not find the parent
> > > directory.
> >
> > No, it's expected behavior since:
> >
> >     commit b215d8e9a71ca8d22df6111ddc9d28bd896febb1
> >     Author: Dave Reisner <dreisner@archlinux.org>
> >     Date:   Wed Apr 25 20:30:52 2012 -0400
> 
> Ok, but this was a regression for a common use case. I guess to late to 
> revert. Even you liked this old behavior:

Well, the common use-case is to not use --target :-) But I agree that
the feature is questionable. The mistake is that the original (non-df)
behavior has not been covered by test. 

> commit 1f42e1089aadbe537bb59143502ebd1767d3f7ea
> Author: Karel Zak <kzak@redhat.com>
> Date:   Sun Jan 2 22:56:31 2011 +0100
> 
>     tests: use findmnt(8) for mount --move test
> 
> 
> > and the current git tree contains:
> >
> >        -T, --target path
> >              Explicitly define the mount target (mountpoint
> >              directory). If the path is not a  mountpoint file
> >              or directory than findmnt checks path elements in
> >              reverse order for get the mountpoint (this
> >              feature is supported only if search in kernel
> >              files and unsupported for --fstab).
> 
> Ah ok, but IMO because of this regression we should make it even more 
> clear. Probably the first sentence should not contain "mount target" 
> and "mountpoint" without also using the term "parent directory" or 
> similar. 
> 
> I think for df(1) it's written nicely:
> 
>   df [OPTION]... [FILE]...
>   Show information about the file system on which each FILE resides, or
>   all file systems by default.

OK.

> > > $TS_CMD_MOUNT --move $DIR_A $DIR_B
> > >
> > > # check the move
> > > $TS_CMD_FINDMNT --kernel --target "$DIR_B" &> /dev/null
> > > [ "$?" == "0" ] || ts_die "Cannot find binded $DIR_B"
> > > [...]
> > >
> > > This findmnt line will never fail I guess.
> >
> > Right, this is mistake, solution is to remove --target:
> >
> >     TS_CMD_FINDMNT --kernel "$DIR_B" &> /dev/null
> 
> >
> > The disadvantage is that without --source/target findmnt(8) tries
> > to use the path as source and then as target. It's bad in same cases.
> >
> > Maybe we need a new option to disable the evaluation of the target
> > path elements. (--strict-target)
> 
> What about "findmnt --target /bla/xyz --no-parents" instead 
> of --strict-target?

No problem.

> I have to admint that I don't really like the current behavior 
> of --target and the default case without --source/target. Of course we 
> can't change it anymore.

Yes, after 3 years it's better to keep the current behavior and
provide an option to disable the "smart" target evaluation. Do you
want to send a patch? (or I can do that tomorrow.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
