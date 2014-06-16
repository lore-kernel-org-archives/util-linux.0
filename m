Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbaFPOAw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jun 2014 10:00:52 -0400
Date: Mon, 16 Jun 2014 16:00:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <eric.rannaud@gmail.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>
Subject: Re: Using findmnt in the presence of a stale NFS mount
Message-ID: <20140616140047.GL30975@x2.net.home>
References: <CA+zRj8Xs=A2sHp3DMD78u9Ak9v-xDSyZVtjB1JGJZ6Dx9t1z=w@mail.gmail.com>
 <20140616132816.GK30975@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140616132816.GK30975@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 16, 2014 at 03:28:16PM +0200, Karel Zak wrote:
> > As it is, it is impossible to upgrade an Arch Linux install when there
> > is a stale NFS mount anywhere on the system (and listed in fstab).
> 
>  You can try to  exclude NFS at all by --types nonfs, but maybe we can
>  add option --nocanonicalize. I'll try to play with that tomorrow. 

OK, tomorrow is now ;-) (the option added)

The problem is that this is not commonly usable solution, because it
very significantly affects the way how libmount search in fstab,
mountinfo etc. The option disallow to reliable compare symlinks, tags etc.

It would be better to have NFS specific solution, or in the
update/install script use --types nonfs and when only if not found
required directories try fallback solution with --nocanonicalize or
so.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
