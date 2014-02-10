Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbaBJSZo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Feb 2014 13:25:44 -0500
Date: Mon, 10 Feb 2014 19:25:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Jesper Dahl Nyerup <nyerup@one.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] scriptreplay: Add --maxdelay option.
Message-ID: <20140210182536.GS8506@x2.net.home>
References: <1392029598-8089-1-git-send-email-nyerup@one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392029598-8089-1-git-send-email-nyerup@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 10, 2014 at 11:53:18AM +0100, Jesper Dahl Nyerup wrote:
>  term-utils/scriptreplay.1 |  6 ++++++
>  term-utils/scriptreplay.c | 15 ++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)

 Applied, thanks.

> +	double divi = 1, maxdelay = 10;

 I have used maxdelay = 0; it seems more readable :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
