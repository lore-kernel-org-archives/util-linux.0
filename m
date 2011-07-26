Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab1GZKQ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jul 2011 06:16:27 -0400
Date: Tue, 26 Jul 2011 12:16:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] whereis: remove find()
Message-ID: <20110726101624.GC22568@nb.net.home>
References: <1311548748.3367.14.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311548748.3367.14.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 24, 2011 at 07:05:48PM -0400, Davidlohr Bueso wrote:
>  misc-utils/whereis.c |   14 +++-----------
>  1 files changed, 3 insertions(+), 11 deletions(-)

 Applied, thanks.

> +		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);

 Please, use space around operators

        findv(srcdirs, ARRAY_SIZE(srcdirs) - 1, cp);

 :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
