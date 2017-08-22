Return-Path: util-linux-owner@vger.kernel.org
Received: from mozilla-myt-1.haze.yandex.net ([77.88.23.115]:36426 "EHLO
        mail.unsafe.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbdHVKiJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Aug 2017 06:38:09 -0400
Received: from comp-core-i7-2640m-0182e6.fortress (ip-89-176-231-42.net.upcbroadband.cz [89.176.231.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 6152ED40F90
        for <util-linux@vger.kernel.org>; Tue, 22 Aug 2017 10:32:01 +0000 (UTC)
Date: Tue, 22 Aug 2017 12:31:58 +0200
From: Alexey Gladkov <legion@altlinux.ru>
To: util-linux@vger.kernel.org
Subject: Re: mount(8) does not support cap_sys_admin
Message-ID: <20170822103158.GB2942@comp-core-i7-2640m-0182e6.fortress>
References: <20170822082047.eczufv3naqlvulsn@cs.unibo.it>
 <20170822084011.vzahylh7qxvcmj3b@cs.unibo.it>
 <20170822091538.f6q7ihuhskc7hw6u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170822091538.f6q7ihuhskc7hw6u@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 22, 2017 at 11:15:38AM +0200, Karel Zak wrote:
> On Tue, Aug 22, 2017 at 10:40:11AM +0200, Renzo Davoli wrote:
> > mount command does not seem to support the cap_sys_admin capability.
> > 
> > In fact the command fails when the mount system call would succeeds
> > for operation permitted to users (e.g. bind mounts in user-namespaces)
> > 
> > For example using userbindmount
> > https://github.com/rd235/userbindmount
> > 
> > $ userbindmount -s --
> > $ mount --bind /tmp/resolv.conf /etc/resolv.conf 
> > mount: only root can use "--bind" option
> > $ busybox mount --bind /tmp/resolv.conf /etc/resolv.conf 
> > $
> > 
> > As it can be seen from the example above, busybox mount
> > succeeds on the same command where mount(8) fails.
> > 
> > "Mount" erroneously checks that the effective user is root
> > and returns an error prior to invoke the system call mount(2),
> > forbidding in this way permitted operations.
> 
> Well, historically mount(8) is not about mount(2) syscall only. It
> also check filesystem type (read from devices), write userspace files
> (/etc/mtab or /run/mount/utab), create loop devices, call btrfs
> ioctls and execute mount helpers.
> 
> We can improve libmount to accept capabilities for simple use-cases
> like --bind, but the question is if it does make sense if for another
> tasks it will be hard to use. 
> 
> Frankly, I have never tried it. Maybe it will not so big issue to try
> it, test it and describe possible limitation in the man page. I'll add
> this to our TODO list.

This issue makes it impossible to use this libmount when you create a new
container. I mean that once you create namespace you can't mount /proc,
/sys, etc. Therefore, the parsing of the flags and checks you have to do
manually, rather than use an existing library.

-- 
Rgrds, legion

