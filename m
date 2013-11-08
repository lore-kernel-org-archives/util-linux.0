Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756875Ab3KHJPs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Nov 2013 04:15:48 -0500
Date: Fri, 8 Nov 2013 10:15:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Simple blkid typeo
Message-ID: <20131108091543.GC10401@x2.net.home>
References: <527BC7C5.8010700@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <527BC7C5.8010700@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 07, 2013 at 12:03:01PM -0500, Phillip Susi wrote:
> - --- a/misc-utils/blkid.c
> +++ b/misc-utils/blkid.c

 Applied, thanks.

 Please, please, use 
 
    git format-patch
    git send-email

 to generate and send patches. It allows me to apply the patches
 directly from maildir. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
