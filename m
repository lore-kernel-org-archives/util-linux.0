Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaJAIPQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 04:15:16 -0400
Date: Wed, 1 Oct 2014 10:14:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org,
        Adam Sampson <ats@offog.org>
Subject: Re: [ANNOUNCE] util-linux v2.25.1
Message-ID: <20141001081452.GI26272@x2.net.home>
References: <1409988445-5256-1-git-send-email-kerolasa@iki.fi>
 <201409061051.58934.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201409061051.58934.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 06, 2014 at 10:51:58AM +0200, Ruediger Meier wrote:
> It still must be "<=":
> +if [ $(bc <<<"(2^64 / $PAGE_SIZE) <= $SHMALL") -eq 1 ]; then

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
