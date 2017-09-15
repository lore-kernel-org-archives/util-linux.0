Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdIOLc2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Sep 2017 07:32:28 -0400
Date: Fri, 15 Sep 2017 13:32:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] rfkill: do not fsync(3) /dev/rfkill file descriptor
Message-ID: <20170915113224.lptz5p4qhspno7so@ws.net.home>
References: <20170911195558.740-1-kerolasa@iki.fi>
 <20170911195558.740-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911195558.740-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 11, 2017 at 08:55:58PM +0100, Sami Kerola wrote:
>  sys-utils/rfkill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
