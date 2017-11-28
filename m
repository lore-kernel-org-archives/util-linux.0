Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbdK1Nw3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Nov 2017 08:52:29 -0500
Date: Tue, 28 Nov 2017 14:52:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] logindefs: remove unused function
Message-ID: <20171128135226.o2ugb7qwnk4dbyzd@ws.net.home>
References: <20171126174751.10500-1-kerolasa@iki.fi>
 <20171126174751.10500-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171126174751.10500-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 26, 2017 at 05:47:50PM +0000, Sami Kerola wrote:
>  login-utils/logindefs.c | 18 ------------------
>  login-utils/logindefs.h |  1 -
>  2 files changed, 19 deletions(-)

All patches applied except this patch. 

I've added free_getlogindefs_data() to su(1) and login(1). It seems
like a good idea to deallocate the config file when we only wait for
child process.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
