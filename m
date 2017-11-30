Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29861 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdK3OWI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 30 Nov 2017 09:22:08 -0500
Date: Thu, 30 Nov 2017 15:22:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Alexey Gladkov <legion@altlinux.ru>
Cc: util-linux@vger.kernel.org
Subject: Re: mount(8) does not support cap_sys_admin
Message-ID: <20171130142203.souwvryy3rt5pmho@ws.net.home>
References: <20170822082047.eczufv3naqlvulsn@cs.unibo.it>
 <20170822084011.vzahylh7qxvcmj3b@cs.unibo.it>
 <20170822091538.f6q7ihuhskc7hw6u@ws.net.home>
 <20170822103158.GB2942@comp-core-i7-2640m-0182e6.fortress>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170822103158.GB2942@comp-core-i7-2640m-0182e6.fortress>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 22, 2017 at 12:31:58PM +0200, Alexey Gladkov wrote:
> On Tue, Aug 22, 2017 at 11:15:38AM +0200, Karel Zak wrote:
> > On Tue, Aug 22, 2017 at 10:40:11AM +0200, Renzo Davoli wrote:
> > > mount command does not seem to support the cap_sys_admin capability.
> > > 
> > > In fact the command fails when the mount system call would succeeds
> > > for operation permitted to users (e.g. bind mounts in user-namespaces)
> > > 
> > > For example using userbindmount
> > > https://github.com/rd235/userbindmount
> > > 
> > > $ userbindmount -s --
> > > $ mount --bind /tmp/resolv.conf /etc/resolv.conf 
> > > mount: only root can use "--bind" option
> > > $ busybox mount --bind /tmp/resolv.conf /etc/resolv.conf 

I try to play with this finally and I'm not sure if I follow you.

You have user namespace, why do you NOT map your euid to root?

 $ echo "nameserver 9.9.9.9" > /tmp/resolv.conf
 $ unshare --mount --user --map-root-user
 # mount --bind /tmp/resolv.conf /etc/resolv.conf
 # cat /etc/resolv.conf
 nameserver 9.9.9.9

your userbindmount map user to user, what is the advantage?

> > Frankly, I have never tried it. Maybe it will not so big issue to try
> > it, test it and describe possible limitation in the man page. I'll add
> > this to our TODO list.
> 
> This issue makes it impossible to use this libmount when you create a new
> container. I mean that once you create namespace you can't mount /proc,
> /sys, etc. Therefore, the parsing of the flags and checks you have to do
> manually, rather than use an existing library.

You can do what you want to do if you're root in your user namespace.

I'm not sure what is expected from mount/libmount in regard to
CAP_SYS_ADMIN. The reason why euid=0 is required by mount(8) is that
years ago some people have installed non-suid mount(8) with
CAP_SYS_ADMIN. 

See http://github.com/karelzak/util-linux/commit/0959f8063bf9b4d576822fe742a2bc9f5d1d1dbc

Unfortunately, this CAP is lightweight version of suid, so we really
don't want to close eyes and follow user wishes... I guess we still
need to verify things against fstab etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
