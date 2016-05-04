Return-Path: James.Bottomley@HansenPartnership.com
Message-ID: <1462367802.14310.41.camel@HansenPartnership.com>
Subject: Re: bind mounting namespace inodes for unprivileged users
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Karel Zak <kzak@redhat.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
Date: Wed, 04 May 2016 09:16:42 -0400
In-Reply-To: <20160504084403.7z67paycj663lkbt@ws.net.home>
References: <1462299656.16133.51.camel@HansenPartnership.com>
	 <20160504084403.7z67paycj663lkbt@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2016-05-04 at 10:44 +0200, Karel Zak wrote:
> On Tue, May 03, 2016 at 02:20:56PM -0400, James Bottomley wrote:
> > Right at the moment, unprivileged users cannot call mount --bind to
> > create a permanent copy of any of their namespaces.  This is
> > annoying
> > because it means that for entry to long running containers you have
> > to
> > spawn an undying process and use nsenter via the /proc/<pid>/ns
> > files.
> 
> Well, unshare is able to create permanent namespaces and the bind
> mounts and nsenter is able to follow these files, but you need root
> permissions to create this stuff.
> 
>  touch /home/kzak/ns
>  sudo unshare --uts=/home/kzak/ns
>  <exit namespace>
> 
>  sudo nsenter --uts=/home/kzak/ns
> 
> it means you really do not need any process in the namespace.

Yes, I do this when I'm root.

> Not sure about unprivileged users, it always sounds like a game with
> Pandora's box ;-)

But that's currently my specific problem: binding a container when I'm
an unprivileged user.  I was thinking of persuading mount to do it, but
unshare could as well, provided it's setuid root.  I'm leery of
proliferating setuid root binaries, which is why I was looking at
mount, but I could easily (more easily than mount) make unshare do it
if that's preferred.

James
