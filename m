Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755563AbdC2Jmf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 29 Mar 2017 05:42:35 -0400
Date: Wed, 29 Mar 2017 11:42:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: util-linux@vger.kernel.org, Stef Walter <stefw@redhat.com>
Subject: Re: agetty reorders characters in login prompt
Message-ID: <20170329094224.vr4d7yucaa4ozplm@ws.net.home>
References: <20170317123053.37e73a6a@litschi.hi.pengutronix.de>
 <20170317121055.c4hv6rb5y4tbpt2c@ws.net.home>
 <20170327130804.xjqfpnw434dtuol5@ws.net.home>
 <20170328183251.649bdb29@litschi.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170328183251.649bdb29@litschi.hi.pengutronix.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 28, 2017 at 06:32:51PM +0200, Michael Tretter wrote:
> Thanks. I tested master and it works now. The echoed user name is
> correct in the automated tests and my manual tests and the login was
> always successful.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
