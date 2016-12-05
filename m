Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbcLEMI5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Dec 2016 07:08:57 -0500
Date: Mon, 5 Dec 2016 13:08:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org,
        Patrick Pelissier <patrick.pelissier@gmail.com>
Subject: Re: [PATCH] chrt: default to SCHED_RR policy
Message-ID: <20161205120850.hl77rvb2mfe3assd@ws.net.home>
References: <1480687818-16387-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480687818-16387-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 02, 2016 at 03:10:18PM +0100, Andreas Henriksson wrote:
> This fixes a regression introduced in:
> 
> commit 7a4ea5664edba98bff28adec3a9c3cfb5763a495
> "chrt: add control struct"
> 
> Previously (and as documented in the manpage) the default policy
> was SCHED_RR. Now it's implicitly SCHED_OTHER (0) as the value
> is not initialized explicitly anymore.

Grr... stupid bug. Sorry.

> Reported-by: Patrick Pelissier <patrick.pelissier@gmail.com>
> Addresses: http://bugs.debian.org/846572
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
