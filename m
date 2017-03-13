Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdCMMIV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 08:08:21 -0400
Date: Mon, 13 Mar 2017 13:08:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] login: prevent OOB read on illegal /etc/hushlogins
Message-ID: <20170313120819.vtkvmpzz7z6r2j5b@ws.net.home>
References: <20170312164945.GB28165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170312164945.GB28165@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 12, 2017 at 05:49:45PM +0100, Tobias Stoeckmann wrote:
>  login-utils/logindefs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
