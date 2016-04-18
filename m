Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51308 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906AbcDRPhh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 11:37:37 -0400
Message-ID: <1460993854.7385.11.camel@HansenPartnership.com>
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: util-linux@vger.kernel.org
Cc: ebiederm@xmission.com
Date: Mon, 18 Apr 2016 11:37:34 -0400
In-Reply-To: <1460982392.2452.6.camel@HansenPartnership.com>
References: <1460982392.2452.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

OK, so if you want me to reply properly, you're going to have to keep
my address in the cc list.

> &gt; If you enter it first, you lose privilege for subsequent
> namespace
> &gt; enters,see issue
> &gt;
> &gt; https://github.com/karelzak/util-linux/issues/315
> &gt;
> &gt; The fix is to enter the user namespace last of all.
> 
> I verified that with *current*/unpatched nsenter,
> 
> $ unshare -rm sleep inf &amp;
> $ nsenter -t $! -U -m --preserve
> 
> works as expected (from regular user [and with unprivileged userns
> enabled]).
> 
> With this patch it *won't* work [verified], of course (as you'll need
> root privileges in userns before joining mount-ns, and you can only
> obtain them by entering userns first).

So we're using userns for different things.  I'm using it to remove
privilege (so on my userns implementation root in the host enters but
on becoming root in the userns, it can do nothing other than write to
its own files) and you're using it to enhance privilege.  It looks like
these two things will always be mutually exclusive, so perhaps we need
an extra flag to nsenter to say do the userns first or last?

> Of course, you can workaround it by invoking nsenter twice:
> 
> $ nsenter -t $! -U --preserve nsenter -t $! -m
> 
> but same could be said about issue 315: you can workaround it by
> manually splitting entering mount-ns and user-ns, something like
> 
> # nsenter --mount=/run/build-container/aarch64 nsenter -
> -user=/run/build-container/user
> 
> or (if /run/build-container/user is not visible inside mount-ns)

That's right, it isn't

> # nsenter --mount=/run/build-container/aarch64 nsenter -
> -user=/dev/fd/3 3&lt;/run/build-container/user

It should work, but for some inexplicable reason it's giving EINVAL.

# nsenter --mount=/run/build-container/aarch64 3</run/build-container/user 
# ls -l /proc/self/fd
total 0
lrwx------ 1 root root 64 Apr 18 15:31 0 -> /dev/pts/1
lrwx------ 1 root root 64 Apr 18 15:31 1 -> /dev/pts/1
lrwx------ 1 root root 64 Apr 18 15:31 2 -> /dev/pts/1
lr-x------ 1 root root 64 Apr 18 15:31 3 -> /run/build-container/user
lr-x------ 1 root root 64 Apr 18 15:31 4 -> /proc/10304/fd
# nsenter --user=/proc/self/fd/3
nsenter: reassociate to namespace 'ns/user' failed: Invalid argument

I think it's because the fd wasn't properly opened by the shell

> (disclaimer: unverified; on my kernel mount-bind fails for mount-ns
> fds).

That's probably because you're running systemd.  Systemd sets all
subtrees to shared and you can only bind mount a mount namespace file
descriptor on to a private subtree.

James

