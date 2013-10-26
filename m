Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15527 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab3JZHqv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 26 Oct 2013 03:46:51 -0400
Date: Sat, 26 Oct 2013 09:46:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk lacks msdos partition support in gpt mode
Message-ID: <20131026074646.GB2119@x2.net.home>
References: <20131024165810.GA26722@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131024165810.GA26722@aepfle.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 24, 2013 at 06:58:10PM +0200, Olaf Hering wrote:
> 
> The guys to decided to use gpt labels even on legacy systems. That
> happens to work. But when it breaks its now difficult to see whats
> actually on disk. Now that fdisk from util-linux 2.23.2 has gpt support
> its unable to print the msdos partition table.
> 
> It would be nice if fdisk gets some do-it-anyway flag to ignore gpt for
> a moment and at least dump such content.

   fdisk -t dos <device>

to force fdisk to use MBR driver only.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
