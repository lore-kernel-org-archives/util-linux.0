Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbaJAJpn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 05:45:43 -0400
Date: Wed, 1 Oct 2014 11:45:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Adam Sampson <ats@offog.org>
Subject: Re: [PATCH 23/23] tests: fix the ipcs test for shmall being too big
 to show
Message-ID: <20141001094527.GK26272@x2.net.home>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
 <1411933916-30576-24-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411933916-30576-24-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 28, 2014 at 08:51:56PM +0100, Sami Kerola wrote:
> diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
> index 1a49c46..4e96ce6 100755
> --- a/tests/ts/ipcs/limits2
> +++ b/tests/ts/ipcs/limits2
> @@ -29,7 +29,7 @@ ts_check_prog "bc"
>  
>  # TODO https://github.com/karelzak/util-linux/issues/51
>  SHMALL=$(</proc/sys/kernel/shmall)
> -if [ $(bc <<<"2^64 / $PAGE_SIZE < $SHMALL") -ne 1 ]; then
> +if [ $(bc <<<"(2^64 / $PAGE_SIZE) <= $SHMALL") -eq 1 ]; then
>  	TS_KNOWN_FAIL="yes"
>  fi

 Ah, I have already fixed this manually :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
