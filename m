Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494Ab1F2JpB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jun 2011 05:45:01 -0400
Date: Wed, 29 Jun 2011 11:44:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] script: remove magic constants and a type mismatch
	fix
Message-ID: <20110629094451.GK6418@nb.net.home>
References: <1309257806-1418-1-git-send-email-kerolasa@iki.fi> <1309257806-1418-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309257806-1418-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 28, 2011 at 12:43:26PM +0200, Sami Kerola wrote:
>  term-utils/script.c |   68 ++++++++++++++++++++++++++------------------------
>  1 files changed, 35 insertions(+), 33 deletions(-)

 Applied.

>>  void
>  fail() {
>  
> -	kill(0, SIGTERM);
> +	kill(getpid(), SIGTERM);
>  	done();
>  }

 I think we want to use zero rather than getpid()...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
