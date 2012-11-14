Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:49494 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932723Ab2KNO1Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 09:27:25 -0500
Date: Wed, 14 Nov 2012 15:27:20 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty and special chars @ and #
Message-ID: <20121114142720.GA23414@boole.suse.de>
References: <20121107165859.GD4383@x2.net.home>
 <20121112100410.GA1887@boole.suse.de>
 <20121112132926.GD26857@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121112132926.GD26857@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 12, 2012 at 02:29:26PM +0100, Karel Zak wrote:
> On Mon, Nov 12, 2012 at 11:04:11AM +0100, Dr. Werner Fink wrote:
> > On Wed, Nov 07, 2012 at 05:58:59PM +0100, Karel Zak wrote:
> > > 
> > >  Hi Werner,
> > > 
> > >  agetty in get_logname() interprets '@' and '#' as a special chars
> > >  (see man page or the code for more details).
> > > 
> > >  The problem is that we already have crazy users who want to use AD
> > >  (access domain) usernames in format user@domain on serial line or
> > >  console.
> > > 
> > >  Yeah, I know that char '@' is not between allowed username chars
> > >  (POSIX 3.429), but do we really need to support the spacial
> > >  interpretation of the @ and # chars?
> > > 
> > >  I think it's old confusing legacy. Objections?
> > 
> > Hmmm ... AFAICR the '@' symbols can be used to set the kill character
> > and the '#' can be used to set the erase character.  But for a virtual
> > console terminal those characters those are normally not used.
> > 
> > Only connections at dialin as well connections over some serial lines
> > with hardware/software line routers/terminal servers between this could
> > be problem.  On big irons such serial lines are used even in the present
> > days.
> > 
> > Maybe it would be worth to introduce an further option to support
> > access domains in user names ... or the other way around to support
> > '@' and '#' as special characters used for software escapes on
> > oldish connection lines.
> 
>  I thought about something like:
> 
>     --erase-chars <string>
>     --kill-chars  <string>
> 
>  and if the string is empty then agetty is insensitive to the special
>  chars. This should be a default for virtual console (or also for
>  serial line?).
> 
>  vice versa
> 
>    agetty --erase-chars '#'
> 
>  enables the support for the char.
> 
>  IMHO this solution is easy to extend (you can use another chars) and
>  provides full control of the feature (you can disable it at all).

Indeed this is a good solution ... but in the case of systemd and its
getty generator we may think about a /etc/agettytab with a similar
syntax scheme as the old /etc/inittab to be able to provide agetty
options based on the used tty line.  Clearly this /etc/agettytab should
be parsed by agetty and options for the specified tty are found:

  1:tty1:--noclear %p
  2:tty2:%p
  3:tty3:%p
  4:tty4:%p
  5:tty5:%p
  6:tty6:%p
  S0:ttyS0:--erase-chars # --kill-chars @ -mt 60 %p 9600,2400,1200
  S1:ttyS0:-L 9600 %p 9600 vt102

... ??

    Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
