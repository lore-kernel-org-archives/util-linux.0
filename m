Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034Ab1G2Iqk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jul 2011 04:46:40 -0400
Date: Fri, 29 Jul 2011 10:46:38 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] miscellaneous compiler warning fixes etc
Message-ID: <20110729084638.GC24754@nb.net.home>
References: <CAG27Bk1-X+eqrVwP7cfZp-9-aCBwPtnYYBRJGi7wBt2-zaOMjA@mail.gmail.com> <20110728224430.GB24754@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110728224430.GB24754@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 29, 2011 at 12:44:30AM +0200, Karel Zak wrote:
> On Thu, Jul 28, 2011 at 11:33:42PM +0200, Sami Kerola wrote:
> > -	iter->done = 1;
> > +	iter->done |= 1;
> 
>  Why we need this change? IMHO it's unnecessary.

 The bit-fields should probably "unsigned int" for better portability, 
 (otherwise it's implementation-defined). I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
