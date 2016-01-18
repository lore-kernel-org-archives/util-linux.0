Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34707 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbcARJOc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jan 2016 04:14:32 -0500
Date: Mon, 18 Jan 2016 10:14:30 +0100
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fix lsns failure after zombie process
Message-ID: <20160118091430.lsphvj7gxep74izu@ws.net.home>
References: <m3r3hih6br.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3r3hih6br.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 16, 2016 at 12:38:00AM +0300, Yuriy M. Kaminskiy wrote:
> --- util-linux.orig/sys-utils/lsns.c
> +++ util-linux/sys-utils/lsns.c
> @@ -308,7 +308,7 @@ static int read_processes(struct lsns *l

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
