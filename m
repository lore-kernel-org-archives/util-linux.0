Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57944 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443AbbBTK3t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Feb 2015 05:29:49 -0500
Date: Fri, 20 Feb 2015 11:29:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] more: fix control character display bug
Message-ID: <20150220102939.GA19430@ws.net.home>
References: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 30, 2015 at 09:54:10AM +0100, Sami Kerola wrote:
>  text-utils/more.c | 59 +++++++++++++++++++++++++------------------------------
>  1 file changed, 27 insertions(+), 32 deletions(-)

Does it make sense to apply this patch? I guess the issue is already
(also) fixed in you "more" branch at git hub, right?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
