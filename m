Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab1KNOX5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 09:23:57 -0500
Date: Mon, 14 Nov 2011 15:23:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] fdisk: split delete_partition() off from
	dos_delete_partition()
Message-ID: <20111114142354.GD23020@nb.net.home>
References: <1321278439-9392-1-git-send-email-cosoleto@gmail.com> <1321278439-9392-3-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321278439-9392-3-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:47:19PM +0100, Francesco Cosoleto wrote:
>  fdisk/fdisk.c |   36 ++++++++++++++++++++++--------------
>  1 files changed, 22 insertions(+), 14 deletions(-)

 Good idea. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
