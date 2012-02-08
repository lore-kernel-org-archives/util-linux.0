Return-Path: fmayhar@google.com
Subject: Re: [PATCH 4/4] fsck: Add support for "completion" scripts.
From: Frank Mayhar <fmayhar@google.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <20120208195006.GB19725@x2.net.home>
References: <1328649055.11787.31.camel@peace.lax.corp.google.com>
	 <20120208162231.GA19725@x2.net.home>
	 <1328720374.11787.46.camel@peace.lax.corp.google.com>
	 <20120208195006.GB19725@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Feb 2012 13:25:36 -0800
Message-ID: <1328736336.11787.79.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-02-08 at 20:50 +0100, Karel Zak wrote:
> On Wed, Feb 08, 2012 at 08:59:34AM -0800, Frank Mayhar wrote:
> > >  The problem is that "device name" is whatever from fsck command line
> > >  or from first fstab column.
> > > 
> > >  Unfortunately the current fsck code does not canonicalize the device
> > >  name -- this is bug because in the function ignore() we stat() the
> > >  device... I'll fix this problem ASAP.
> > 
> > If the device name is canonicalized, I think the problem generally goes
> > away.
> 
>  You miss the point. Yes, we can resolve the problem with UUID= or
>  LABEL= in /etc/fstab, but the problem is that nothing guarantees that
>  the canonical kernel device name (e.g. /dev/sda) will the same after
>  reboot.  This is reason why we use things like UUID= or
>  /dev/disk/by-* for block devices.

This is true in the general case but is more of an administrative issue
(in my opinion) and depends heavily on the configuration (of both the
machine and the distribution).  (In my _particular_ case, it isn't true,
in fact.)  Regardless, however, the real reason I'm resistant to using
the uuid for the logfile name is that it's just not very human-friendly.
That may also be true for certain kinds of device names, but to me
"fsck-d0c0t0s0" or "fsck-sda1" is much easier to deal with than
"fsck-bfb8fb54-5b31-11df-98e8-00e081337e9a".

>  Anyway, no problem to support /etc/fsck.d/<devname>/ but preferred and
>  recommended will be definitely <uuid>.

My inclination is to leave it up to the individual admin, but I have no
strong feeling about it.

> > and my goal was to keep
> > things as simple as possible.  Setting environment variables might be
> > sufficient, though.
> >
> > One thing I remembered last night that I forgot to document is that the
> > last parameter is optional and is the logfile name (including path) if
> > the -L option was given.  I'll generate one more patch to fsck.8 (based
> > on the current set of patches) to fix that, although if we go with
> > environment variables then it's no longer a problem.
> > 
> > For my own purposes, I would really like to keep the invocation as-is
> > and fall back to environment variables if there are no arguments on the
> > command line.  This would make my life a _lot_ easier.
> 
>  I understand, but I'd like to have a solution which is usable for
>  more people and easy to maintain for upstream :-)  What about
> 
>    /etc/fsck.d/completion <devname> <status>
> 
>  and the rest of information by FSCK_* env.variables ? The env.
>  variables should be pretty simple to use in the script.

Yeah, I could go with this.  Do you want to code it up or shall I?
-- 
Frank Mayhar
fmayhar@google.com
