Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932246AbcEEJpM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 May 2016 05:45:12 -0400
Date: Thu, 5 May 2016 11:45:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Victor Dodon <dodonvictor@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: exit with error if rereading partition table
 fails
Message-ID: <20160505094510.dx74xuipc7yrytud@ws.net.home>
References: <1461223498-19392-1-git-send-email-dodonvictor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461223498-19392-1-git-send-email-dodonvictor@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 21, 2016 at 12:24:58AM -0700, Victor Dodon wrote:
>  disk-utils/sfdisk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, good enough for now. Thanks. 

I'm going to improve [s]fdisk return codes later.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
