Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44620 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbaBQLwm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 06:52:42 -0500
Date: Mon, 17 Feb 2014 12:52:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: chrt requires priority argument
Message-ID: <20140217115238.GC2254@x2.net.home>
References: <52F3F4F1.5000007@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F3F4F1.5000007@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 06, 2014 at 03:47:45PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> chrt requires a priority argument, even for classes ( like batch )
> that do not support them.  If you specify a non zero value, then the
> command fails.  I think the argument should be ignored and forced to
> zero for these classes

 Well, why do you expect this correction in userspace? I really
 don't like when we're trying to be more smart than kernel.

 For example for setpriority() is kernel able to do the correction
 for prio argument when the argument is out of the expected range. For
 some reason sched_setscheduler() is not so smart and incorrect
 priority ends with error.

 IMHO is better to follow kernel for so low-level utils like chrt(1)
 than silently hide mistakes in usage. And the current code is also
 ready for possible future kernel changes -- implement extra
 corrections and policies in userspace means that one day you will in
 conflict with your kernel.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
