Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:35513 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbcDROd3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 10:33:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1asAEw-0005XV-BU
	for util-linux@vger.kernel.org; Mon, 18 Apr 2016 16:33:26 +0200
Received: from ppp37-190-56-88.pppoe.spdop.ru ([37.190.56.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 16:33:26 +0200
Received: from yumkam by ppp37-190-56-88.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 16:33:26 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
Date: Mon, 18 Apr 2016 17:33:12 +0300
Message-ID: <m3ega3kmvr.fsf@gmail.com>
References: <1460982392.2452.6.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

James Bottomley
<James.Bottomley@HansenPartnership.com>
writes:

> If you enter it first, you lose privilege for subsequent namespace
> enters,see issue
>
> https://github.com/karelzak/util-linux/issues/315
>
> The fix is to enter the user namespace last of all.

I verified that with *current*/unpatched nsenter,

$ unshare -rm sleep inf &
$ nsenter -t $! -U -m --preserve

works as expected (from regular user [and with unprivileged userns
enabled]).

With this patch it *won't* work [verified], of course (as you'll need
root privileges in userns before joining mount-ns, and you can only
obtain them by entering userns first).

Of course, you can workaround it by invoking nsenter twice:

$ nsenter -t $! -U --preserve nsenter -t $! -m

but same could be said about issue 315: you can workaround it by
manually splitting entering mount-ns and user-ns, something like

# nsenter --mount=/run/build-container/aarch64 nsenter --user=/run/build-container/user

or (if /run/build-container/user is not visible inside mount-ns)

# nsenter --mount=/run/build-container/aarch64 nsenter --user=/dev/fd/3 3</run/build-container/user
  
(disclaimer: unverified; on my kernel mount-bind fails for mount-ns fds).

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index d8690db..1525f15 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -52,13 +52,13 @@ static struct namespace_file {
>  	 * first.  This gives an unprivileged user the potential to
>  	 * enter the other namespaces.
>  	 */
> -	{ .nstype = CLONE_NEWUSER,  .name = "ns/user", .fd = -1 },
>  	{ .nstype = CLONE_NEWCGROUP,.name = "ns/cgroup", .fd = -1 },
>  	{ .nstype = CLONE_NEWIPC,   .name = "ns/ipc",  .fd = -1 },
>  	{ .nstype = CLONE_NEWUTS,   .name = "ns/uts",  .fd = -1 },
>  	{ .nstype = CLONE_NEWNET,   .name = "ns/net",  .fd = -1 },
>  	{ .nstype = CLONE_NEWPID,   .name = "ns/pid",  .fd = -1 },
>  	{ .nstype = CLONE_NEWNS,    .name = "ns/mnt",  .fd = -1 },
> +	{ .nstype = CLONE_NEWUSER,  .name = "ns/user", .fd = -1 },
>  	{ .nstype = 0, .name = NULL, .fd = -1 }
>  };

