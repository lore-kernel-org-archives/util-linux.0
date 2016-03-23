Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbcCWKIO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Mar 2016 06:08:14 -0400
Date: Wed, 23 Mar 2016 11:08:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Romain Naour <romain.naour@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsipc: don't free shm data if no shm id is found
Message-ID: <20160323100812.s4k2izvi26iqavji@ws.net.home>
References: <1458681594-2085-1-git-send-email-romain.naour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458681594-2085-1-git-send-email-romain.naour@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 22, 2016 at 10:19:54PM +0100, Romain Naour wrote:
>  sys-utils/lsipc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
