Return-Path: matthew@linuxfromscratch.org
Message-ID: <1331492786.1816.2.camel@kyoto.localdomain>
Subject: Re: mount -f regression in v2.21's new-mount
From: Matt Burgess <matthew@linuxfromscratch.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 11 Mar 2012 19:06:26 +0000
In-Reply-To: <20120309122926.GH17711@x2.net.home>
References: <20120309105304.GF17711@x2.net.home>
	 <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
	 <20120309122926.GH17711@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Fri, 2012-03-09 at 13:29 +0100, Karel Zak wrote:
> On Fri, Mar 09, 2012 at 04:30:02AM -0700, Matthew Burgess wrote:
> > On Fri, 9 Mar 2012 11:53:04 +0100, Karel Zak <kzak@redhat.com> wrote:
> > > On Thu, Mar 08, 2012 at 08:25:00PM +0000, Matt Burgess wrote:
> > >> I've attached LIBMOUNT_DEBUG output from the 'mount -a' call that our
> > >> bootscript does.  Note how mount correctly detects that /proc, /sys
> > > 
> > >  No, it calls mount(2) syscall for /proc. The problem is that the
> > >  detection code expects /proc/self/mountinfo (used on systems with
> > >  mtab -> /proc/mounts symlink), but your system uses regular mtab.
> > > 
> > >  I'll fix it. Thanks.
> 
>  Fixed, try git pull.

Thanks, that's sorted it!
> 
> > Thanks!  Is there a consensus opinion on whether users should be
> > using a regular mtab or a symlink to /proc/self/mountinfo?
> 
>  - disadvantage is that some userspace utils (e.g. df(1) are not able
>    to de-duplicate list of mounted filesystem (bind mounts))
> 
>  + advantage is that there is only one list of mounted filesystems
>    with always valid mount options (on systems with mtab is not problem
>    to have 'rw' in mtab for read-only NFS, etc.), no problems with
>    namespaces, not writable files in /etc, no mtab lock, etc.
> 
>  The symlink is required for systemd.

Thanks for the info.  Looks like there are more advantages than
disadvantages.  Without wishing to stray too far off-topic, do you know
if the Coreutils folks are aware of/looking at the 'df' issue?

Matt.
