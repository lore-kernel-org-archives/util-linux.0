Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42683 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdFFPKj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Jun 2017 11:10:39 -0400
Date: Tue, 6 Jun 2017 17:10:35 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Bug: mount doing bad security check: only root can use -types,
 (effective EUID is 5013)
Message-ID: <20170606151035.ok32sbrjc6k3ttza@ws.net.home>
References: <5935E44B.8000405@tlinx.org>
 <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
 <5936B8E5.8050901@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5936B8E5.8050901@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 06, 2017 at 07:15:01AM -0700, L A Walsh wrote:
> Karel Zak wrote:
> > ruid = getuid();
> >     euid = geteuid();
> > 
> >     cxt->restricted = (uid_t) 0 == ruid && ruid == euid ? 0 : 1;
> > 
> > in your case geteuid() returns 5013.
> ----
>    But my EUID isn't 5013 ("LOGINUID" is). That's the complaint/bug. 

The code it pretty simple, it just get euid from kernel and print
it. The error message is independent on another code and libmount.
I don't see any room for bug there. Your euid is 5013. 

You can also try "strace -o log mount --types xxx /dev/foo /mnt/bar" 
and see the "log" file where will be geteuid()...

This code is without relevant changes since 2011-01-10.

    Karel

static void __attribute__((__noreturn__)) exit_non_root(const char *option)
{
	const uid_t ruid = getuid();
	const uid_t euid = geteuid();

	if (ruid == 0 && euid != 0) {
		/* user is root, but setuid to non-root */
		if (option)
			errx(MNT_EX_USAGE, _("only root can use \"--%s\" option "
					 "(effective UID is %u)"),
					option, euid);
		errx(MNT_EX_USAGE, _("only root can do that "
				 "(effective UID is %u)"), euid);
	}
	if (option)
		errx(MNT_EX_USAGE, _("only root can use \"--%s\" option"), option);
	errx(MNT_EX_USAGE, _("only root can do that"));
}


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
