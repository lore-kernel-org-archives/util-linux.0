Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49373 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000AbbCEJgu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Mar 2015 04:36:50 -0500
Date: Thu, 5 Mar 2015 10:36:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/16] flock: improve timeout handling
Message-ID: <20150305093638.GU8046@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:33PM +0000, Sami Kerola wrote:
> +	sig_a.sa_flags = SA_SIGINFO;
> +	sig_a.sa_handler = (void (*)(int))timeout_handler;

man sigaction:

 If SA_SIGINFO is specified in sa_flags, then sa_sigaction (instead of
 sa_handler) specifies the signal-handling function for signum.

I'll fix it...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
