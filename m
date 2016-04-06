Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/2] libuuid: remove HAVE_UUIDD
Date: Wed, 6 Apr 2016 12:55:58 +0100
Cc: util-linux@vger.kernel.org
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de> <20160406113552.6nrd4xnqjjrwqbrc@ws.net.home>
In-Reply-To: <20160406113552.6nrd4xnqjjrwqbrc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604061355.59565.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 April 2016, Karel Zak wrote:
> On Wed, Apr 06, 2016 at 12:51:06PM +0200, Ruediger Meier wrote:
> > configure --disable-uuidd disabled both the build of uuidd and also
> > disabled uuidd support of libuuid.
>
>  Yes.
>
> > Now we build libuuid always with uuidd support.
>
>  Not sure if I follow... we always build uuidd and uuidd support
>  within libuuid except situation you specify --disable-uuidd.
>
> > +++ b/libuuid/src/gen_uuid.c
> > @@ -329,7 +329,7 @@ try_again:
> >  	return ret;
> >  }
> >
> > -#if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
> > +#ifdef HAVE_SYS_UN_H
>
>  So you want uuidd stuff in libuuid although --disable-uuidd has been
>  specified? Why?

Same reason like for the 2nd patch. openSUSE packagers want do disable 
uuidd in the "first stage build" because of systemd dependency. But 
they still want full functionality in libbuuid. They build uuidd later 
in "stage 2".

Personally I don't like this openSUSE packaging style. But I see the 
general problem that util-linux as a bunch of low-level tools has 
already too much dependencies (systemd, python). This can be annoying 
for certain ways how distros do their bootstrapping.

>  The --disable-uuidd is (or should be) pretty common for desktop-only
>  distros.

I thought why shouldn't libbuuid always try the uuidd socket? Like glibc 
always tries nscd, regardless if that evil beast is running or not. 
Does it matter that nscd or uuidd was not built? Maybe one wants to use 
another implementations of these daemons.

>  IMHO the current behaviour is correct.

What about adding --enable-libuuid-force-uuidd without changing any 
current behavior?

cu,
Rudi
