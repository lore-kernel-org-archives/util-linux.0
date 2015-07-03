Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] script: evaluate errno only if read() sets it
Date: Fri, 3 Jul 2015 12:33:47 +0200
Cc: util-linux@vger.kernel.org
References: <201507021206.47499.sweet_f_a@gmx.de> <201507021221.02981.sweet_f_a@gmx.de> <20150703080426.GH26962@ws.net.home>
In-Reply-To: <20150703080426.GH26962@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201507031233.47481.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Friday 03 July 2015, Karel Zak wrote:
> On Thu, Jul 02, 2015 at 12:21:02PM +0200, Ruediger Meier wrote:
> > I have a question and a comment about my own patch :)
> >
>  :-)
>
> I have applied the patch with some small changes:
> > On Thursday 02 July 2015, Ruediger Meier wrote:
> > > @@ -367,7 +365,7 @@ static void handle_signal(struct
> > > script_control *ctl, int fd)
> > >
> > >  	bytes = read(fd, &info, sizeof(info));
> > >  	if (bytes != sizeof(info)) {
> > > -		if (errno == EAGAIN)
> > > +		if (bytes < 0 && errno == EAGAIN)
> > >  			return;
> >
> > Should we also return on EINTR here like we do in handle_io()?
>
> It's probably more robust, Fixed.

BTW there is another potential issue for systems where EAGAIN != 
EWOULDBLOCK. These systems might be seldom but who knows exactly? If we 
don't want to care about EWOULDBLOCK in whole util-linux then we 
should maybe abort configure if both are not equal ... and wait for 
complaining users.

see
http://stackoverflow.com/questions/7003234/which-systems-define-eagain-and-ewouldblock-as-different-values

I've tested on AIX but when using gcc and/or the right defines I've
got EAGAIN == EWOULDBLOCK there too.

cu,
Rudi
