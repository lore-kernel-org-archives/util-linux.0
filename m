Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934567AbdDFKnq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 06:43:46 -0400
Date: Thu, 6 Apr 2017 12:43:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH 0/5] some fincore fixes
Message-ID: <20170406104341.b6vs4s5ny7gdcck5@ws.net.home>
References: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 06, 2017 at 09:56:00AM +0200, Ruediger Meier wrote:
> This patch-set tries to make the fincore tests more reliable on non-x86
> systems and some non-default file systems. It discoverd one bug in
> fincore itself.

Applied, thanks.

> Ruediger Meier (5):
>   tests: remove fincore SMALLER_THAN_PAGESIZE tests
>   tests: fix fincore/count for PAGE_SIZE != 4096
>   fincore: fix multiplication overflow

I have removed "int" from the code at all for the sizes.

>   tests: handle dd errors in fincore/count
>   tests: fincore/count, skip unsupported FS

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
