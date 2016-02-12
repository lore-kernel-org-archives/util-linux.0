Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbcBLKXb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 05:23:31 -0500
Date: Fri, 12 Feb 2016 11:23:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Sulogin: avoid shared memory area usemask but use
 waitid() for childs
Message-ID: <20160212102330.xbnmnmm7epamtznz@ws.net.home>
References: <1455194126-29497-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455194126-29497-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 11, 2016 at 01:35:26PM +0100, Werner Fink wrote:
>  login-utils/sulogin-consoles.c |  53 ++++++++++++++++-----
>  login-utils/sulogin.c          | 104 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 120 insertions(+), 37 deletions(-)

 Applied, thanks.

> +	struct timespec sigwait = {0, 50000000};

 Modified to:

     struct timespec sigwait = { .tv_sec = 0, .tv_nsec = 50000000 };

to keep it more robust.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
