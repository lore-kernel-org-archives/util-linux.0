Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499Ab3KDOLV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 09:11:21 -0500
Date: Mon, 4 Nov 2013 15:11:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blockdev: don't use HDIO_GETGEO
Message-ID: <20131104141118.GC21311@x2.net.home>
References: <1383327425-2694-1-git-send-email-psusi@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383327425-2694-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 01, 2013 at 01:37:05PM -0400, Phillip Susi wrote:
>  disk-utils/blockdev.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

 Applied with minor changes, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
