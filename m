Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbaBJR1G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Feb 2014 12:27:06 -0500
Date: Mon, 10 Feb 2014 18:26:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] last: make session gone determination more robust
Message-ID: <20140210172651.GJ8506@x2.net.home>
References: <1390341905-23864-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390341905-23864-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 21, 2014 at 10:05:05PM +0000, Sami Kerola wrote:
>  login-utils/last.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

 No perfect, but better than the previous version.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
