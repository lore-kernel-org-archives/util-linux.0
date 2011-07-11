Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab1GKKEq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 06:04:46 -0400
Date: Mon, 11 Jul 2011 12:04:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Kirill Elagin <kirelagin@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix install-exec-hook to check whether wall and write
	were built
Message-ID: <20110711100442.GG5214@nb.net.home>
References: <CABVT_geJbR477C0OBrT1_Mn+iz0sUEE7mLuG56JytoF15uMHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABVT_geJbR477C0OBrT1_Mn+iz0sUEE7mLuG56JytoF15uMHTg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 05, 2011 at 09:13:51PM +0400, Kirill Elagin wrote:
> Signed-off-by: Kirill Elagin <kirelagin@gmail.com>
> ---
>  term-utils/Makefile.am |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)

 Thanks, but it seems already fixed by

 commit 73ae0d5be6e070afe83d1a2324ac79941629201e
 Author: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
