Return-Path: fmayhar@google.com
Subject: Re: [PATCH 4/4] fsck: Add support for "completion" scripts.
From: Frank Mayhar <fmayhar@google.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <20120208162231.GA19725@x2.net.home>
References: <1328649055.11787.31.camel@peace.lax.corp.google.com>
	 <20120208162231.GA19725@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Feb 2012 08:59:34 -0800
Message-ID: <1328720374.11787.46.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-02-08 at 17:22 +0100, Karel Zak wrote:
> On Tue, Feb 07, 2012 at 01:10:55PM -0800, Frank Mayhar wrote:
> > Add support for scripts that are run when each individual fsck
> > completes.  This allows certain general or file- or device-specific
> > actions to be taken when each fsck finishes.
> > 
> > Signed-off-by: Frank Mayhar <fmayhar@google.com>
> > 
> >  fsck/fsck.8 |   60
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fsck/fsck.c |   62
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fsck/fsck.h |    4 ++-
> >  3 files changed, 125 insertions(+), 1 deletions(-)
> > 
> > diff --git a/fsck/fsck.8 b/fsck/fsck.8
> > index d56b0d7..7e5b55b 100644
> > --- a/fsck/fsck.8
> > +++ b/fsck/fsck.8
> > @@ -413,6 +413,60 @@ and
> >  do not support the
> >  .B -y
> >  option as of this writing.
> > +.SH COMPLETION SCRIPTS
> > +.B fsck
> > +has a mechanism available by which to run a script when each check
> > completes.
> > +If when
> > +.B fsck
> > +starts the directory
> > +.IR /etc/fsck.d
> > +(or see FSCK_COMPLETION_PATH below) exists and is readable,
> > +.B fsck
> > +will use it to find such scripts.  Scripts there must be named one of
> > +.IR /etc/fsck.d/device/name ", " /etc/fsck.d/fstype/name ,
> 
>  The problem is that "device name" is whatever from fsck command line
>  or from first fstab column.
> 
>  Unfortunately the current fsck code does not canonicalize the device
>  name -- this is bug because in the function ignore() we stat() the
>  device... I'll fix this problem ASAP.

If the device name is canonicalized, I think the problem generally goes
away.

>  Maybe it would be better to somehow standardize the names used for
>  fsck-log and the completion scripts.
> 
>  What about to use
> 
>     /etc/fsck.d/uuid/<uuid>
>     /var/log/fsck/fsck-<uuid>

Adding the uuid as a potential completion script makes a lot of sense;
I'm a little hesitant about using the uuid in the logfile name, since
it's typically pretty long and could easily make the filename unwieldy.
That's part of what the completion script is for, too:  To potentially
canonicalize the logfile name into whatever form makes sense locally.

I would want to keep the devname, fstype and generic completion scripts
the same, though.  Just add the uuid one as you indicate.

>  rather than devname? I guess that all usable filesystems provides
>  UUIDs now and fsck is already linked with libblkid.
> 
>  If you agree than ignore this problem for now, I'll implement it.
> 
> > +.I system(3)
> 
>  Why we need to execute the scripts by system(3)? Why not classic execv?

The completion script could as easily be an executable binary; I just
figured I would let system() take care of it for me.  If you have a
strong objection, I could change it but at the moment I see no strong
reason to worry about it.

> > +  /etc/fsck.d/device/hdc1 /dev/hdc1 ext4 0 1.60470 0.41193 0.76588 9828
> 
>  I don't like the fixed set of parameters, it will be difficult to extend
>  such solution in the future.

Mostly I wanted something that would be trivial to parse.  I thought
about regular command line options but that makes the completion script
a lot bigger (all the option-parsing code) and my goal was to keep
things as simple as possible.  Setting environment variables might be
sufficient, though.

One thing I remembered last night that I forgot to document is that the
last parameter is optional and is the logfile name (including path) if
the -L option was given.  I'll generate one more patch to fsck.8 (based
on the current set of patches) to fix that, although if we go with
environment variables then it's no longer a problem.

For my own purposes, I would really like to keep the invocation as-is
and fall back to environment variables if there are no arguments on the
command line.  This would make my life a _lot_ easier.
-- 
Frank Mayhar
fmayhar@google.com
