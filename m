Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbdF0NOH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 09:14:07 -0400
Date: Tue, 27 Jun 2017 15:14:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH 0/5] Ambient capabilities for setpriv
Message-ID: <20170627131401.esuakjnceifwpwn4@ws.net.home>
References: <cover.1498312509.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1498312509.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 04:04:29PM +0200, Patrick Steinhardt wrote:
> Patrick Steinhardt (5):
>   setpriv: introduce indirection for `capng_type` enum
>   setpriv: proxy function checking whether a capability is set
>   setpriv: proxy function to update capabilities
>   setpriv: support dumping ambient capabilities
>   setpriv: support modifying the set of ambient capabilities
> 
>  sys-utils/setpriv.1 |   8 ++--
>  sys-utils/setpriv.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 103 insertions(+), 14 deletions(-)

Applied. (You've forgot to add --ambient-caps to usage(), fixed by
additional commit.)

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
