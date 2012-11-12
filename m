Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53836 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab2KLKEP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Nov 2012 05:04:15 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 099BEA39CE
	for <util-linux@vger.kernel.org>; Mon, 12 Nov 2012 11:04:14 +0100 (CET)
Date: Mon, 12 Nov 2012 11:04:11 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: agetty and special chars @ and #
Message-ID: <20121112100410.GA1887@boole.suse.de>
References: <20121107165859.GD4383@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121107165859.GD4383@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 07, 2012 at 05:58:59PM +0100, Karel Zak wrote:
> 
>  Hi Werner,
> 
>  agetty in get_logname() interprets '@' and '#' as a special chars
>  (see man page or the code for more details).
> 
>  The problem is that we already have crazy users who want to use AD
>  (access domain) usernames in format user@domain on serial line or
>  console.
> 
>  Yeah, I know that char '@' is not between allowed username chars
>  (POSIX 3.429), but do we really need to support the spacial
>  interpretation of the @ and # chars?
> 
>  I think it's old confusing legacy. Objections?

Hmmm ... AFAICR the '@' symbols can be used to set the kill character
and the '#' can be used to set the erase character.  But for a virtual
console terminal those characters those are normally not used.

Only connections at dialin as well connections over some serial lines
with hardware/software line routers/terminal servers between this could
be problem.  On big irons such serial lines are used even in the present
days.

Maybe it would be worth to introduce an further option to support
access domains in user names ... or the other way around to support
'@' and '#' as special characters used for software escapes on
oldish connection lines.


   Werner

http://www.linusakesson.net/programming/tty/
http://digilander.libero.it/robang/rubrica/serial.htm

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
