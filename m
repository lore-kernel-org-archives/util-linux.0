Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbcBBKOX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 05:14:23 -0500
Date: Tue, 2 Feb 2016 11:14:21 +0100
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Message-ID: <20160202101421.5gacl352rb4ajhjz@ws.net.home>
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
 <1428578536-31603-2-git-send-email-kzak@redhat.com>
 <87bnix6xj6.fsf@x220.int.ebiederm.org>
 <20150410081733.GM3923@ws.net.home>
 <m31t8zhgfv.fsf@gmail.com>
 <m3twlvfb39.fsf@gmail.com>
 <20160201104114.5iv5hznaslpi2xkz@ws.net.home>
 <m3mvrkfqoc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3mvrkfqoc.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 01, 2016 at 05:31:15PM +0300, Yuriy M. Kaminskiy wrote:
> Karel Zak <kzak@redhat.com> writes:
> 
> > On Sat, Jan 30, 2016 at 04:31:06PM +0300, Yuriy M. Kaminskiy wrote:
> >> >> +	case 0:	/* child */
> >> >> +		do {
> >> >> +			/* wait until parent unshare() */
> >> >> +			ino_t new_ino = get_mnt_ino(ppid);
> >> >> +			if (ino != new_ino)
> >> >> +				break;
> >> >> +		} while (1);
> >> >
> >> > Racing? Suppose, parent died (e.g. unshare(2) failed), (parent) process
> >> > was reaped, new (unrelated) process was created with same pid, as a
> >> > result this function will bind namespaces from wrong process.
> >> 
> >> ... besides, this is a busyloop, if "imposer process" is in same mnt
> >> namespace as original process, it will occupy CPU forever (and this *is*
> >
> > Would be possible to use any lightweight solution rather than
> > pipe()+read/write(), for example use sigtimedwait() in child and
> > kill() in parent?
> 
> With my patch, if parent dies, child is automatically awoken (got EOF and
> cleanly exit). With signals, it is not.
> (Besides, it is not easy to set up without introducing more racing.)

OK, fair enough.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
