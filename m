Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbaHKNMM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 09:12:12 -0400
Date: Mon, 11 Aug 2014 15:12:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/5] logger: optimize string initializations
Message-ID: <20140811131201.GK17719@x2.net.home>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
 <1407671771-29745-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407671771-29745-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 10, 2014 at 12:56:09PM +0100, Sami Kerola wrote:
> -	char pid[32] = { '\0' }, time[64] = { '\0' }, timeq[80] = { '\0' };
> +	char pid[32], time[64], timeq[80];

 I agree that the original code is not elegant, but "else foo[0] =
 '\0'" is also pretty ugly. It would be better to set all to the
 default by one line

   *pid = *time = *timeq = '\0';

 at begin of the function.


>  	if ((process = get_process_id(ctl)))
>  		snprintf(pid, sizeof(pid), " %d", process);
> +	else
> +		pid[0] = '\0';

 I really don't like hairy code like this.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
