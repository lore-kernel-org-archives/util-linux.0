Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752262AbdEPM5v (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 May 2017 08:57:51 -0400
Date: Tue, 16 May 2017 14:57:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sulogin: remove duplicate const declaration
Message-ID: <20170516125735.kr3zxx4i63nikf3u@ws.net.home>
References: <20170516082557.18918-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170516082557.18918-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 16, 2017 at 09:25:57AM +0100, Sami Kerola wrote:
>  login-utils/su-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied (but with 'su:' rather than 'sulogin:' prefix), thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
