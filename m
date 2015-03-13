Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:58077 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbbCMNCe convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 Mar 2015 09:02:34 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: =?windows-1252?q?P=E1draig_Brady?= <P@draigbrady.com>
Subject: Re: tailf, really needed?
Date: Fri, 13 Mar 2015 14:02:30 +0100
Cc: util-linux@vger.kernel.org
References: <201503131000.29307.sweet_f_a@gmx.de> <5502CBFF.6090405@draigBrady.com>
In-Reply-To: <5502CBFF.6090405@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201503131402.30431.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 13 March 2015, Pádraig Brady wrote:
> On 13/03/15 09:00, Ruediger Meier wrote:
> > Hi,
> >
> > As far as I understood tailf's advantage over "tail -f" is that it
> > does not access the file when it does not grow. But nowadays
> > coreutils "tail -f" also does not seem to access the file. So do we
> > really need tailf?
> >
> > The point is that I've noticed that our tailf fails to deal with
> > filesystems where inotify is broken. For example it does not work
> > for overlayfs. coreutils tail code looks quite complicated and
> > seems to manage such cases. Is it worth to fix our tailf or better
> > just remove it and use "tail -f"?
> >
> > BTW coreutils tail is much more comfortable. It has many important
> > options. For example watching log files without -F or --retry does
> > not make sense to me (because of logrotate).
> >
> > Last but not least, is anybody using tailf at all? Google does not
> > find much about people who are using this.
>
> tailf is a strange one. If there was an issue with tail(1) accessing
> the files, then why not fix it? In any case it seems without inotify
> that tailf(1) does access the file?
>
>   nanosleep({0, 250000000}, NULL)         = 0
>   open("file", O_RDONLY)    = 3
>   fstat(3, {st_mode=S_IFREG|0664, st_size=7048, ...}) = 0
>   close(3)
>
> while tail -f does not:
>
>   nanosleep({0, 1000000000}, NULL)         = 0
>   fstat(3, {st_mode=S_IFREG|0664, st_size=7048, ...}) = 0

Yes, I also checked this. The case undefined HAVE_INOTIFY_INIT is broken 
since inotify support was added in 2007, fc7aeb09.

BTW I think there could be a minor improvement for coreutils tail for 
the cases "file is empty" or "-n 0". Maybe we could skip opening the 
file one time at the beginning. So that "tail -n0 -f logfile" would 
really never access the file unless it grows.

cu,
Rudi
