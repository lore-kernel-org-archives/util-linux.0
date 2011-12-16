Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758886Ab1LPNMq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Dec 2011 08:12:46 -0500
Date: Fri, 16 Dec 2011 14:12:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/13] fdisk: remove unused 'require' member in enum
	action
Message-ID: <20111216131243.GG25486@nb.net.home>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 15, 2011 at 08:02:37PM +0100, Francesco Cosoleto wrote:
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c

 All (13) patches applied. Good work, you fixed exactly the things
 that I have hated (poor separation of DOS and non-DOS code).

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
