Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:54336 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbbCMOCu convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 Mar 2015 10:02:50 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: =?windows-1252?q?P=E1draig_Brady?= <P@draigbrady.com>
Subject: Re: tailf, really needed?
Date: Fri, 13 Mar 2015 15:02:47 +0100
Cc: util-linux@vger.kernel.org
References: <201503131000.29307.sweet_f_a@gmx.de> <201503131402.30431.sweet_f_a@gmx.de> <5502E79E.20605@draigBrady.com>
In-Reply-To: <5502E79E.20605@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201503131502.47576.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 13 March 2015, Pádraig Brady wrote:
> On 13/03/15 13:02, Ruediger Meier wrote:
> > On Friday 13 March 2015, Pdraig Brady wrote:
> >> On 13/03/15 09:00, Ruediger Meier wrote:
> >>> Hi,
> >>>
> >>> As far as I understood tailf's advantage over "tail -f" is that
> >>> it does not access the file when it does not grow. But nowadays
> >>> coreutils "tail -f" also does not seem to access the file. So do
> >>> we really need tailf?
> >>>
> >>> The point is that I've noticed that our tailf fails to deal with
> >>> filesystems where inotify is broken. For example it does not work
> >>> for overlayfs. coreutils tail code looks quite complicated and
> >>> seems to manage such cases. Is it worth to fix our tailf or
> >>> better just remove it and use "tail -f"?
> >>>
> >>> BTW coreutils tail is much more comfortable. It has many
> >>> important options. For example watching log files without -F or
> >>> --retry does not make sense to me (because of logrotate).
> >>>
> >>> Last but not least, is anybody using tailf at all? Google does
> >>> not find much about people who are using this.
> >>
> >> tailf is a strange one. If there was an issue with tail(1)
> >> accessing the files, then why not fix it? In any case it seems
> >> without inotify that tailf(1) does access the file?
> >>
> >>   nanosleep({0, 250000000}, NULL)         =0
> >>   open("file", O_RDONLY)    =3
> >>   fstat(3, {st_mode=S_IFREG|0664, st_sizep48, ...}) =0
> >>   close(3)
> >>
> >> while tail -f does not:
> >>
> >>   nanosleep({0, 1000000000}, NULL)         =0
> >>   fstat(3, {st_mode=S_IFREG|0664, st_sizep48, ...}) =0
> >
> > Yes, I also checked this. The case undefined HAVE_INOTIFY_INIT is
> > broken since inotify support was added in 2007, fc7aeb09.
> >
> > BTW I think there could be a minor improvement for coreutils tail
> > for the cases "file is empty" or "-n 0". Maybe we could skip
> > opening the file one time at the beginning. So that "tail -n0 -f
> > logfile" would really never access the file unless it grows.
>
> I see what you mean, though I'm not convinced it's worth complicating
> GNU tail for that edge case. Not updating atime is mainly a
> performance concern. I.e. you want to avoid the continuous open() of
> the file
> (though relatime alleviates a lot of that concern these days).
>
> Are there valid cases where you really don't want to update atime
> for logical reasons?

Not personally for me. Actually most filesystems are mounted noatime or 
relatime per default anyways.

I just thought about the use case of the original author of tailf. tailf 
was made to not wake up HD during the "read loop". But why waking it up 
initially?

Another thought would be to generally look for such edge cases in any 
commands where we could avoid some initial open or read calls. Maybe 
this could safe some HD "start stop counts" even on a regular existing 
system. Would be just a minor contribution to save some energy.

cu,
Rudi
