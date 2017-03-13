Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753248AbdCMNp4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 09:45:56 -0400
Date: Mon, 13 Mar 2017 14:45:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/13] lib/colors: assert rathen than overflow
Message-ID: <20170313134543.jd5k4hnygmeb4moh@ws.net.home>
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-14-kerolasa@iki.fi>
 <20170313134354.ximcvarayhcv7b5s@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170313134354.ximcvarayhcv7b5s@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 13, 2017 at 02:43:54PM +0100, Karel Zak wrote:
> > +	assert (len < (out - *seq));
> 
> This seems incorrect. Should be:
> 
>     assert ((out - *seq) <= len);

Merged with this line.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
