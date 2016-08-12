Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33971 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcHLV3r (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 12 Aug 2016 17:29:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so5228343wma.1
        for <util-linux@vger.kernel.org>; Fri, 12 Aug 2016 14:29:46 -0700 (PDT)
Date: Fri, 12 Aug 2016 22:29:41 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] uuidd: require use of --socket-activation when run
 as systemd service
In-Reply-To: <20160808102211.ijejkvnutrbrz2xp@ws.net.home>
Message-ID: <alpine.LNX.2.20.1608122226560.13547@imuri>
References: <20160803224158.23657-1-kerolasa@iki.fi> <20160808102211.ijejkvnutrbrz2xp@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 8 Aug 2016, Karel Zak wrote:

> On Wed, Aug 03, 2016 at 11:41:57PM +0100, Sami Kerola wrote:
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  misc-utils/uuidd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
> > index a3fe830..77c967d 100644
> > --- a/misc-utils/uuidd.c
> > +++ b/misc-utils/uuidd.c
> > @@ -651,6 +651,13 @@ int main(int argc, char **argv)
> >  	else if (pidfile_path_param)
> >  		pidfile_path = pidfile_path_param;
> >  
> > +#ifdef HAVE_LIBSYSTEMD
> > +	if (getppid() == 1 && 0 < sd_booted() &&
> > +	    (!uuidd_cxt.no_sock || !uuidd_cxt.no_fork || !no_pid))
> > +		errx(EXIT_FAILURE,  _("cannot run as systemd service "
> > +				      "without --socket-activation"));
> > +#endif
> 
>  Why? 
>  
>  I do not test it, but I guess --socket-activation is always an
>  optional way. It's enabled by default in systemd unit files, but I
>  guess for some test purpose you can use old way to start uuid
>  independently on your initd. Right?

My thinking with this was that when software can detect correct
invocation it should. In this case when uuidd is started by
systemd then incorrect option usage in service file should
cause an error.

But indeed, perhaps an unnecessary change so I'm not going to
push this any further.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
