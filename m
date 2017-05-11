Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755444AbdEKMYq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 May 2017 08:24:46 -0400
Date: Thu, 11 May 2017 14:24:42 +0200
From: Karel Zak <kzak@redhat.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: util-linux@vger.kernel.org
Subject: Re: libmount: Is the 'defaults' option intentionally a no-op?
Message-ID: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
References: <20170511114032.GB3035@valgrind.tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170511114032.GB3035@valgrind.tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 11, 2017 at 04:40:32AM -0700, W. Trevor King wrote:
> I'm having trouble squaring the docs in mount(8) [1]:
> 
>   defaults
>     Use the default options: rw, suid, dev, exec, auto, nouser,  and
>     async.
> 
>     Note  that  the real set of all default mount options depends on
>     kernel and filesystem type.  See the beginning of  this  section
>     for more details.
...

> As far as I can tell, that makes 'defaults' a no-op.  For example, it
> doesn't clear MS_RDONLY:
> 
>   # strace -o /tmp/trace mount -t tmpfs -o ro,defaults - /tmp/a
>   # grep 'mount(' /tmp/trace
>   mount("-", "/tmp/a", "tmpfs", MS_MGC_VAL|MS_RDONLY, NULL) = 0
> 
> But using ‘rw’ directly does:
> 
>   # strace -o /tmp/trace mount -t tmpfs -o ro,rw - /tmp/a
>   # grep 'mount(' /tmp/trace
>   mount("-", "/tmp/a", "tmpfs", MS_MGC_VAL, NULL) = 0

That's true and expected.

> And as you can see in those strace logs, the presence of ‘defaults’ in
> userspace_opts_map means that it doesn't get passed through in
> mount(2)'s ‘data’ argument either.
> 
> I can think of a few possibilities:
> 
> a. ‘defaults’ is supposed to be a no-op placeholder for the fourth
>    fstab field.  We should drop it from examples that set any other
>    options (like [5]) and update the man entries [1,2] to remove the
>    references to ‘rw’, ‘suid’, etc. and replace them with markers on
>    the inverted settings listed by

It's placeholder, but kernel uses some options like "rw,exec,suid" by
default, so it's described in the man page... I agree the description
and relation between kernel defaults and the placeholder should be
described more clearly.

> c. ‘defaults’ is supposed to be shorthand for
>    ‘rw,suid,dev,exec,auto,nouser,async’.  It should be implemented
>    with something like:

No way, we really don't want to do any default setting in userspace.


My suggestion (man page):

  default 

   No-op placeholder with no impact to the filesystem mount options.

   The real mount options depends on built-in kernel defaults and
   default mount options defined by filesystem superblock. The usual
   kernel behaviour is to mount filesystems with rw, suid and exec
   flags by default. See the beginning of this section for more details.

   The "default" is interpreted as "auto" by "mount -a".

Is it better than the current description?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
