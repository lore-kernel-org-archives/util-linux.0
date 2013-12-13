Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7808 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab3LMKpp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Dec 2013 05:45:45 -0500
Date: Fri, 13 Dec 2013 11:45:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Phillip Susi <psusi@ubuntu.com>,
        util-linux@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: read only bind mount ignores ready only
Message-ID: <20131213104516.GN16572@x2.net.home>
References: <52A878C5.6050505@ubuntu.com>
 <20131212120544.GJ16572@x2.net.home>
 <CAJfpegvWeEb7Dtk8CMxLO4DB-xSLQMxLxccUPReU0GeQ=9d5MA@mail.gmail.com>
 <20131212215325.GE10323@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131212215325.GE10323@ZenIV.linux.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 12, 2013 at 09:53:25PM +0000, Al Viro wrote:
> 	Frankly, I wonder if we are trying to pack too much into one
> syscall - not just in terms of overloading it (that much is obvious),
> but in terms of trying to cram a sequence of syscalls into one.  If
> we end up introducing new API(s) for mount(), it's probably worth
> considering something like this:
> 	* open a connection to fs type driver, get a descriptor
> 	* use normal IO syscalls (usually just write(2)) on that
> descriptor to tell fs type driver what do we want.  If any kind of
> authentication is needed, that's the time for doing it
> 	* attach the thing identified by that descriptor to mountpoint

Yes, exactly. This is my wish for years.

I don't think we need more *independent* syscalls to replace mount(2)
(for example a special syscall to change propagation flags, or so).

I strongly believe that APIs for complex tasks have to be based on 
handlers (file descriptors). These APIs are extendible.

It would be also nice to provide some information about the mount
operation to userspace by the file descriptor -- it means to support
read(2) and at least to return mount Id.  The current situation when
we have only errno in userspace is insufficient. If you want to know
more information then you have parse /proc/self/mountinfo, but which
entry in the right entry for the last mount(2) call?

> I have an old writeup somewhere (several variants of it, actually) on possible
> replacement APIs; I'll try to dig it out and post it.

 Please, share it :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
