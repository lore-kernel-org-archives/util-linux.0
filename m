Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757210Ab2BHTuJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Feb 2012 14:50:09 -0500
Date: Wed, 8 Feb 2012 20:50:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Frank Mayhar <fmayhar@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] fsck: Add support for "completion" scripts.
Message-ID: <20120208195006.GB19725@x2.net.home>
References: <1328649055.11787.31.camel@peace.lax.corp.google.com>
 <20120208162231.GA19725@x2.net.home>
 <1328720374.11787.46.camel@peace.lax.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328720374.11787.46.camel@peace.lax.corp.google.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 08, 2012 at 08:59:34AM -0800, Frank Mayhar wrote:
> >  The problem is that "device name" is whatever from fsck command line
> >  or from first fstab column.
> > 
> >  Unfortunately the current fsck code does not canonicalize the device
> >  name -- this is bug because in the function ignore() we stat() the
> >  device... I'll fix this problem ASAP.
> 
> If the device name is canonicalized, I think the problem generally goes
> away.

 You miss the point. Yes, we can resolve the problem with UUID= or
 LABEL= in /etc/fstab, but the problem is that nothing guarantees that
 the canonical kernel device name (e.g. /dev/sda) will the same after
 reboot.  This is reason why we use things like UUID= or
 /dev/disk/by-* for block devices.

 Anyway, no problem to support /etc/fsck.d/<devname>/ but preferred and
 recommended will be definitely <uuid>.

> >  Maybe it would be better to somehow standardize the names used for
> >  fsck-log and the completion scripts.
> > 
> >  What about to use
> > 
> >     /etc/fsck.d/uuid/<uuid>
> >     /var/log/fsck/fsck-<uuid>
> 
> Adding the uuid as a potential completion script makes a lot of sense;
> I'm a little hesitant about using the uuid in the logfile name, since
> it's typically pretty long and could easily make the filename unwieldy.
> That's part of what the completion script is for, too:  To potentially
> canonicalize the logfile name into whatever form makes sense locally.
> 
> I would want to keep the devname, fstype and generic completion scripts
> the same, though.  Just add the uuid one as you indicate.
> 
> >  rather than devname? I guess that all usable filesystems provides
> >  UUIDs now and fsck is already linked with libblkid.
> > 
> >  If you agree than ignore this problem for now, I'll implement it.
> > 
> > > +.I system(3)
> > 
> >  Why we need to execute the scripts by system(3)? Why not classic execv?
> 
> The completion script could as easily be an executable binary; I just
> figured I would let system() take care of it for me.  If you have a
> strong objection, I could change it but at the moment I see no strong
> reason to worry about it.
> 
> > > +  /etc/fsck.d/device/hdc1 /dev/hdc1 ext4 0 1.60470 0.41193 0.76588 9828
> > 
> >  I don't like the fixed set of parameters, it will be difficult to extend
> >  such solution in the future.
> 
> Mostly I wanted something that would be trivial to parse.  I thought
> about regular command line options but that makes the completion script
> a lot bigger (all the option-parsing code)

 Good point.

> and my goal was to keep
> things as simple as possible.  Setting environment variables might be
> sufficient, though.
>
> One thing I remembered last night that I forgot to document is that the
> last parameter is optional and is the logfile name (including path) if
> the -L option was given.  I'll generate one more patch to fsck.8 (based
> on the current set of patches) to fix that, although if we go with
> environment variables then it's no longer a problem.
> 
> For my own purposes, I would really like to keep the invocation as-is
> and fall back to environment variables if there are no arguments on the
> command line.  This would make my life a _lot_ easier.

 I understand, but I'd like to have a solution which is usable for
 more people and easy to maintain for upstream :-)  What about

   /etc/fsck.d/completion <devname> <status>

 and the rest of information by FSCK_* env.variables ? The env.
 variables should be pretty simple to use in the script.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
