Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaG2HxB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 03:53:01 -0400
Date: Tue, 29 Jul 2014 09:52:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] logger: ensure program writes everything to syslog
 file descriptor
Message-ID: <20140729075250.GP8533@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
 <1406066459-4816-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406066459-4816-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 11:00:50PM +0100, Sami Kerola wrote:
> @@ -281,8 +282,8 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
>                 snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
                  ^^^^^^^^^^
>  			pri, tp, cp, pid, msg);
>  
> +	       if (write_all(fd, buf, strlen(buf)+1) < 0)
                                  ^^^^^^^^^^
> +		       warn(_("write failed"));

 Do we really need strlen() if there is snprintf(buf, ....)?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
