Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754229Ab1GKLFr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 07:05:47 -0400
Date: Mon, 11 Jul 2011 13:05:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Kirill Elagin <kirelagin@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix double free in mount.c with SELinux enabled
Message-ID: <20110711110543.GI5214@nb.net.home>
References: <CABVT_gfBiyqfbmDNB9aPiMAWsFLFwn64WhuJi=EA0-oy3cnsTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABVT_gfBiyqfbmDNB9aPiMAWsFLFwn64WhuJi=EA0-oy3cnsTQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 06, 2011 at 01:50:37AM +0400, Kirill Elagin wrote:
>  mount/mount.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
