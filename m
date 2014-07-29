Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43867 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbaG2IXa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 04:23:30 -0400
Date: Tue, 29 Jul 2014 10:23:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] logger: ensure program writes everything to syslog
 file descriptor
Message-ID: <20140729082319.GQ8533@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
 <1406066459-4816-2-git-send-email-kerolasa@iki.fi>
 <20140729075250.GP8533@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140729075250.GP8533@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 29, 2014 at 09:52:50AM +0200, Karel Zak wrote:
> On Tue, Jul 22, 2014 at 11:00:50PM +0100, Sami Kerola wrote:
> > @@ -281,8 +282,8 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
> >                 snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
>                   ^^^^^^^^^^
> >  			pri, tp, cp, pid, msg);
> >  
> > +	       if (write_all(fd, buf, strlen(buf)+1) < 0)
>                                   ^^^^^^^^^^
> > +		       warn(_("write failed"));
> 
>  Do we really need strlen() if there is snprintf(buf, ....)?

 I'm going to improve this, you don't have send a new version.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
