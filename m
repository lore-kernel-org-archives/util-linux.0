Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933444AbcHaHuc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 Aug 2016 03:50:32 -0400
Date: Wed, 31 Aug 2016 09:50:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Set errno in is_loopdev on error
Message-ID: <20160831075030.4mnfju7laq2cx2qk@ws.net.home>
References: <20160830190038.GA32582@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160830190038.GA32582@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 30, 2016 at 09:00:38PM +0200, Tobias Stoeckmann wrote:
>  lib/loopdev.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

 Good catch. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
