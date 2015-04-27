Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbbD0I6g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Apr 2015 04:58:36 -0400
Date: Mon, 27 Apr 2015 10:58:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] mkfs: drop hardcoded search path
Message-ID: <20150427085834.GL27969@ws.net.home>
References: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 12, 2015 at 05:06:51AM -0400, Mike Frysinger wrote:
>  disk-utils/mkfs.8 | 16 ++--------------
>  disk-utils/mkfs.c | 17 +----------------
>  2 files changed, 3 insertions(+), 30 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
