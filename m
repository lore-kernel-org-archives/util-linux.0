Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbbEKKZz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 May 2015 06:25:55 -0400
Date: Mon, 11 May 2015 12:25:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Michael Marineau <michael.marineau@coreos.com>
Subject: Re: [PATCH] libfdisk: (gpt) fix attributes endianess
Message-ID: <20150511102545.GM27969@ws.net.home>
References: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 08, 2015 at 01:39:53PM +0200, Ruediger Meier wrote:
> The new libfdisk/gpt test (4a4a0927) discovered that we read and write
> partition attributes wrongly on BE systems.

It was pretty hidden bug (as the problem was in the both set/get
functions).

I have added hexdump to GPT sfdisk test to make sure we produce the
same label on all archs.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
