Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41953 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdAQLvy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 17 Jan 2017 06:51:54 -0500
Date: Tue, 17 Jan 2017 12:51:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] last: use --time-format instruction when printing wtmp
 creation time
Message-ID: <20170117115146.tjswoiqsahkzuu4e@ws.net.home>
References: <20170115101718.8885-1-kerolasa@iki.fi>
 <20170116112528.x72dn2pcxjxbfjp7@ws.net.home>
 <alpine.LNX.2.20.1701162236440.12085@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1701162236440.12085@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 16, 2017 at 10:40:05PM +0000, Sami Kerola wrote:
> Well \n removal has to be somewhere and it does make sense to move it to 
> time_formatter().  How about the following that is also available at:
> 
>   git://github.com/kerolasa/lelux-utiliteetit.git last

Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
