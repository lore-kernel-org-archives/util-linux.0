Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdE2KTP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 29 May 2017 06:19:15 -0400
Date: Mon, 29 May 2017 12:19:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fix variable shadowing
Message-ID: <20170529101911.xvvt6djl5ert2em5@ws.net.home>
References: <20170527090355.28183-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170527090355.28183-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 27, 2017 at 10:03:55AM +0100, Sami Kerola wrote:
>  libfdisk/src/context.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied (with small change), thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
