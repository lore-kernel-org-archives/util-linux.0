Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10278 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab2LTI6E (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Dec 2012 03:58:04 -0500
Date: Thu, 20 Dec 2012 09:58:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Michal Soltys <soltys@ziu.info>
Cc: util-linux@vger.kernel.org
Subject: Re: hwclock recent commits - question
Message-ID: <20121220085800.GF17959@x2.net.home>
References: <50D1E252.5070805@ziu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50D1E252.5070805@ziu.info>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 19, 2012 at 04:50:42PM +0100, Michal Soltys wrote:
> Namely regarding commit:
> 
> 839be2ba6b44fa9dc927f081d547ebadec9de19c
> 
> and subsequent Tom's fix:
> 
> 910a090039cbd529041bfb5f6be72bf27a96bd47
> 
> 
> From what I can see, the "old" and current hwclock's behaviour is actually
> identical, with exception of relying on either warp_clock() call (current
> version, one-shot only) or do_settimeofday() (previous version, consistent
> on each call).
> 
> Was the switch to warp_clock() the main reason after the change, or were
> there other issues with standard approach ?

 Yes, we want to use the warp_clock(), the problem with the old
 version is that without warp_clock() the time will be modified every
 time. It's unexpected, because the time should be modified only once
 (=during boot).
 
 Unfortunately we have bug reports from "creative people" who are able
 to call hwclock --systz more then once. The current warp_clock()
 based solution is more robust.

 Note that systemd uses the same method to setup system time (it does
 not call hwclock).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
