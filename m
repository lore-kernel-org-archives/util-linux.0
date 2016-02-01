Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:58439 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418AbcBAOb7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Feb 2016 09:31:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aQFWE-0003sh-Lp
	for util-linux@vger.kernel.org; Mon, 01 Feb 2016 15:31:54 +0100
Received: from ppp37-190-56-5.pppoe.spdop.ru ([37.190.56.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 01 Feb 2016 15:31:49 +0100
Received: from yumkam by ppp37-190-56-5.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 01 Feb 2016 15:31:49 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Date: Mon, 01 Feb 2016 17:31:15 +0300
Message-ID: <m3mvrkfqoc.fsf@gmail.com>
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
	<1428578536-31603-2-git-send-email-kzak@redhat.com>
	<87bnix6xj6.fsf@x220.int.ebiederm.org>
	<20150410081733.GM3923@ws.net.home> <m31t8zhgfv.fsf@gmail.com>
	<m3twlvfb39.fsf@gmail.com>
	<20160201104114.5iv5hznaslpi2xkz@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Sat, Jan 30, 2016 at 04:31:06PM +0300, Yuriy M. Kaminskiy wrote:
>> >> +	case 0:	/* child */
>> >> +		do {
>> >> +			/* wait until parent unshare() */
>> >> +			ino_t new_ino = get_mnt_ino(ppid);
>> >> +			if (ino != new_ino)
>> >> +				break;
>> >> +		} while (1);
>> >
>> > Racing? Suppose, parent died (e.g. unshare(2) failed), (parent) process
>> > was reaped, new (unrelated) process was created with same pid, as a
>> > result this function will bind namespaces from wrong process.
>> 
>> ... besides, this is a busyloop, if "imposer process" is in same mnt
>> namespace as original process, it will occupy CPU forever (and this *is*
>
> Would be possible to use any lightweight solution rather than
> pipe()+read/write(), for example use sigtimedwait() in child and
> kill() in parent?

With my patch, if parent dies, child is automatically awoken (got EOF and
cleanly exit). With signals, it is not.
(Besides, it is not easy to set up without introducing more racing.)

> The ideal solution would be to have /proc/self/ns/<name> files poll()-able.

I'm not sure how it can fit with the way ns/<name> exposed by kernel
currently (symlink to ns inode). (And more racing opportunities too).

