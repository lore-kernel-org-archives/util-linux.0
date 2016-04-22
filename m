Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58092 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbcDVJJM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 05:09:12 -0400
Date: Fri, 22 Apr 2016 11:09:10 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck -l: fix racing between unlock/unlink and open
Message-ID: <20160422090910.pdgmgsh5dagb5wxc@ws.net.home>
References: <m3bn5lqdvi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3bn5lqdvi.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 08, 2016 at 12:59:29AM +0300, Yuriy M. Kaminskiy wrote:
> Cons: leaves empty (unlocked/harmless) .lock files in /run/fsck/
> Signed-off-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
> ---
>  disk-utils/fsck.c | 1 -
>  1 file changed, 1 deletion(-)

I have applied this KISS solution.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
