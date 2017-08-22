Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbdHVJPm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Aug 2017 05:15:42 -0400
Date: Tue, 22 Aug 2017 11:15:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: util-linux@vger.kernel.org
Subject: Re: mount(8) does not support cap_sys_admin
Message-ID: <20170822091538.f6q7ihuhskc7hw6u@ws.net.home>
References: <20170822082047.eczufv3naqlvulsn@cs.unibo.it>
 <20170822084011.vzahylh7qxvcmj3b@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170822084011.vzahylh7qxvcmj3b@cs.unibo.it>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 22, 2017 at 10:40:11AM +0200, Renzo Davoli wrote:
> mount command does not seem to support the cap_sys_admin capability.
> 
> In fact the command fails when the mount system call would succeeds
> for operation permitted to users (e.g. bind mounts in user-namespaces)
> 
> For example using userbindmount
> https://github.com/rd235/userbindmount
> 
> $ userbindmount -s --
> $ mount --bind /tmp/resolv.conf /etc/resolv.conf 
> mount: only root can use "--bind" option
> $ busybox mount --bind /tmp/resolv.conf /etc/resolv.conf 
> $
> 
> As it can be seen from the example above, busybox mount
> succeeds on the same command where mount(8) fails.
> 
> "Mount" erroneously checks that the effective user is root
> and returns an error prior to invoke the system call mount(2),
> forbidding in this way permitted operations.

Well, historically mount(8) is not about mount(2) syscall only. It
also check filesystem type (read from devices), write userspace files
(/etc/mtab or /run/mount/utab), create loop devices, call btrfs
ioctls and execute mount helpers.

We can improve libmount to accept capabilities for simple use-cases
like --bind, but the question is if it does make sense if for another
tasks it will be hard to use. 

Frankly, I have never tried it. Maybe it will not so big issue to try
it, test it and describe possible limitation in the man page. I'll add
this to our TODO list.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
