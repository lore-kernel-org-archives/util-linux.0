Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab3BCP2M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 3 Feb 2013 10:28:12 -0500
Date: Sun, 3 Feb 2013 16:28:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Why "--fake" and "--no-canonicalize" started requiring root in
 2.22?
Message-ID: <20130203152809.GA17182@x2.net.home>
References: <CAOMFOmWOvh2TAp5a61esH=2Kzgt_YkQ5dHvQOz=_k53zzx20Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMFOmWOvh2TAp5a61esH=2Kzgt_YkQ5dHvQOz=_k53zzx20Xg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 03, 2013 at 01:39:50AM -0800, Anatol Pomozov wrote:
> I am trying to compile and use libfuse. Libfuse utilises 'mount' and
> 'umount' tools. One of few things it uses are "--fake" and
> "--no-canonicalize" command options run as regular user. It worked
> fine with previous versions of util-linux (2.20 from Ubuntu Precise).
> But in the latest version (2.22 from Arch) it fails to run as a
> regular user:

The original (now deprecated) mount code:

# git blame --date=short -L 2572,+11 mount-deprecated/mount.c 

3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2572) 		if (restricted &&
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2573) 		    (types || options || readwrite || nomtab || mount_all ||
be9adec4 mount/mount.c (Karel Zak 2009-12-17 2574) 		     nocanonicalize || fake || mounttype ||
be9adec4 mount/mount.c (Karel Zak 2009-12-17 2575) 		     (argc + specseen) != 1)) {
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2576) 
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2577) 			if (ruid == 0 && euid != 0)
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2578) 				/* user is root, but setuid to non-root */
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2579) 				die (EX_USAGE, _("mount: only root can do that "
b7481d6f mount/mount.c (Karel Zak 2010-06-14 2580) 					"(effective UID is %u)"), euid);
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2581) 
3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2582) 			die (EX_USAGE, _("mount: only root can do that"));

for example:

commit be9adec40ffc81b28cbb051d0aa1f46f596f7b81
Author: Karel Zak <kzak@redhat.com>
Date:   Thu Dec 17 12:27:16 2009 +0100

    mount: disable --no-canonicalize for non-root users
        
    Signed-off-by: Karel Zak <kzak@redhat.com>


> $  mount --version
> mount from util-linux 2.22.2 (libmount 2.22.0: debug)
> $  mount --fake
> mount: only root can use "--fake" option

fake was always disable for non root users

> $  mount --no-canonicalize
> mount: only root can use "--no-canonicalize" option
> 
> Should it be removed from the list of "restricted" options like it
> happened with other options recently? This would restore the same
> behavior that "mount" had before.

I don't see a change...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
