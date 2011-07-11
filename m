Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab1GKKC4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 06:02:56 -0400
Date: Mon, 11 Jul 2011 12:02:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: use a single variable for the current disklabel
Message-ID: <20110711100252.GB9930@nb.net.home>
References: <1309687281-6403-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309687281-6403-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 03, 2011 at 12:01:21PM +0200, Francesco Cosoleto wrote:
>  fdisk/fdisk.c         |  142 ++++++++++++++++++++++++-------------------------
>  fdisk/fdisk.h         |   15 ++++--
>  fdisk/fdiskaixlabel.c |    5 +--
>  fdisk/fdiskmaclabel.c |    5 +--
>  fdisk/fdisksgilabel.c |    6 +--
>  fdisk/fdisksunlabel.c |    4 +-
>  6 files changed, 85 insertions(+), 92 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
