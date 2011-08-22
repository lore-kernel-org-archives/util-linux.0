Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab1HVMBb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Aug 2011 08:01:31 -0400
Date: Mon, 22 Aug 2011 14:01:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org, Thorsten Kukuk <kukuk@suse.de>
Subject: Re: PAM-only login(1)
Message-ID: <20110822120123.GC20457@nb.net.home>
References: <20110812115758.GC1843@nb.net.home> <4E523B50.8080204@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4E523B50.8080204@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2011 at 01:19:44PM +0200, Ludwig Nussel wrote:
> Karel Zak wrote:
> >   I'd like to clean up login(1) code for v2.21. The current code is
> >   mess with many #ifdef and support for some unused (and badly tested) 
> >   features (e.g. non-PAM support for /etc/securetty and /etc/usertty).
> > 
> >   What about to finally create nice and readable PAM-only login(1) for
> >   Linux?
> 
> +1
> 
> On openSUSE we already use a pam-only login program¹. It was forked

It would be nice to merge all back to util-linux and share the code
rather than maintain forks.

> from util-linux > ten years ago AFAICT. It also includes features
> from shadow-utils, like reading settings from /etc/login.defs.

Does make anything other than MAIL_DIR sense for login(1)?

(IMHO the MAIL_DIR could be also defined by pam_env.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
