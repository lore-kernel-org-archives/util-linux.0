Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbbAZK2q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 05:28:46 -0500
Date: Mon, 26 Jan 2015 11:28:38 +0100
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] textual: put option and its description into a
 single translatable string
Message-ID: <20150126102838.GG6354@x2.net.home>
References: <1421613631-5732-1-git-send-email-bensberg@justemail.net>
 <1421613631-5732-3-git-send-email-bensberg@justemail.net>
 <54BC1F79.1030706@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54BC1F79.1030706@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 18, 2015 at 04:02:49PM -0500, JWP wrote:
> On 01/18/2015 03:40 PM, Benno Schulenberg wrote:
> > Also improve the description: notime, notq, and nohost are literals,
> > not things to be replaced by something else -- so no angular brackets.
> > 
> > Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> > ---
> >  misc-utils/logger.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> > index 35caf9d..296f7f0 100644
> > --- a/misc-utils/logger.c
> > +++ b/misc-utils/logger.c
> > @@ -525,8 +525,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
> >  	fputs(_(" -T, --tcp             use TCP only\n"), out);
> >  	fputs(_(" -d, --udp             use UDP only\n"), out);
> >  	fputs(_("     --rfc3164         use the obsolete BSD syslog protocol\n"), out);
> > -	fputs(_("     --rfc5424[=<notime,notq,nohost>]\n"), out);
> > -	fputs(_("                       use the syslog protocol (default)\n"), out);
> > +	fputs(_("     --rfc5424[=<cut>] use the syslog protocol (the default);\n"
> > +		"                         <cut> can be notime, or notq, and/or nohost\n"), out);
> 
> I have never see that done before, it seems confusing.
> Isn't the commonly used term 'snip'?

 Yes, I have replaced <cut> with <snip>.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
