Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:41036 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbCAM1B (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 07:27:01 -0500
Received: by widex7 with SMTP id ex7so9101942wid.0
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 04:27:00 -0800 (PST)
Date: Sun, 1 Mar 2015 12:26:58 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/13] bash-completion: add freeze mode to rtcwake
In-Reply-To: <20150224130137.GS19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011224450.822@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi> <1424616139-638-11-git-send-email-kerolasa@iki.fi> <20150224130137.GS19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:42:16PM +0000, Sami Kerola wrote:
> > Missed when commit ece44f19f423408f576f348fed2845c876d72c6e added support
> > to freeze.
> > 
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  bash-completion/rtcwake | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/bash-completion/rtcwake b/bash-completion/rtcwake
> > index 51566a2..70ae743 100644
> > --- a/bash-completion/rtcwake
> > +++ b/bash-completion/rtcwake
> > @@ -12,7 +12,7 @@ _rtcwake_module()
> >  			return 0
> >  			;;
> >  		'-m'|'--mode')
> > -			COMPREPLY=( $(compgen -W "standby mem disk off no on disable show" -- $cur) )
> > +			COMPREPLY=( $(compgen -W "standby freeze mem disk off no on disable show" -- $cur) )
> 
>  would be possible to ask rtcwake(8) for all supported modes rather
>  than hard code it to the bash-completion script?

Thanks Karel,

Great idea. Change is updated to provide dynamic mode listing.

https://github.com/kerolasa/lelux-utiliteetit/commit/d827893773d9b565c42dd3300cdf4495891a08b2

Notice that the later change will update the listing to include only the 
modes from /sys/power/state.

https://github.com/kerolasa/lelux-utiliteetit/commit/9c147fa6ae5d4a8dcbb40e4bb8d6b82c408c52ed

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
