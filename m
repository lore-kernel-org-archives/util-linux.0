Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbeC0Lxn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Mar 2018 07:53:43 -0400
Date: Tue, 27 Mar 2018 13:53:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] closestream: remove dummy function __fpending()
Message-ID: <20180327115337.nbnv4ld4wwqhrdzx@ws.net.home>
References: <20180310212024.5126-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180310212024.5126-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 10, 2018 at 09:20:24PM +0000, Sami Kerola wrote:
>  include/closestream.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
