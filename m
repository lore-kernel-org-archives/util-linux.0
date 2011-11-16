Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab1KPNIG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 08:08:06 -0500
Date: Wed, 16 Nov 2011 14:08:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/15] prlimit: fix displaying of modified limits
Message-ID: <20111116130801.GM7916@nb.net.home>
References: <4EC07388.6030400@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07388.6030400@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:56AM +0100, Bernhard Voelker wrote:
> [PATCH 15/15] prlimit: fix displaying of modified limits
>
> When a limit is to be modified and shown, e.g. in
>   $ prlimit -p$$  -n1000 -n
> then the prlimit syscall has overwritten lims[i].rlim with the old value.
> For such cases, copy the new values afterwards again.

 This is also unnecessary now, but I have a little improved this
 thing, so the syscall is not called with the same pointer for new and
 old argument now.

 Thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
