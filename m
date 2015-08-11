Return-Path: util-linux-owner@vger.kernel.org
Received: from zproxy02.unex.es ([158.49.17.43]:54673 "EHLO zproxy02.unex.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964793AbbHKL57 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Aug 2015 07:57:59 -0400
Date: Tue, 11 Aug 2015 13:57:56 +0200
From: Santiago Vila <sanvila@unex.es>
To: util-linux <util-linux@vger.kernel.org>
Cc: 794727@bugs.debian.org
Subject: Re: "mesg n" exits with error, even if the command is successful
Message-ID: <20150811115756.GA25905@cantor.unex.es>
References: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
 <7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de>
 <20150809171906.GA27138@cantor.unex.es>
 <CAG27Bk2LoBzp122dkL7npkMSa0iEEVajE3EqMVFYnPbn5zDBHA@mail.gmail.com>
 <20150809191119.GA29884@cantor.unex.es>
 <20150811103222.GA13425@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150811103222.GA13425@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[ Trimming Cc lines a little bit ].

On Tue, Aug 11, 2015 at 12:32:22PM +0200, Karel Zak wrote:
> I think Posix standard is pretty explicit:
> 
> EXIT STATUS
> The following exit values shall be returned:
>     0 Receiving messages is allowed.
>     1 Receiving messages is not allowed.
>     >1 An error occurred.
> 
> 
> but you're asking for 0 also when 'n' or 'y' operants are specified.
> For me it seems like complicated return code semantic...

It is not complicated, it is usual Unix behaviour: Most commands
return 0 on success and > 0 on error (often, they return a different
number > 0 according to the type of error).

If I say "mesg n", and the mesg command is actually able to disable
writes to the terminal, that should count as successful, because it
did what I asked it.

But it still exits with 1, which usually indicates error, and this
forces shell script writers to write extra code.

I would call *that* complicated, not the current behaviour.

> I think standard wants to keep the things simple and stupid without
> any extra exceptions (another exit codes when executed with operants).
> [...]

On the contrary, I think standard is simple but not because they tried
to make it simple, but just because they forgot to make it *sensible*,
apparently nobody thought that it is probably a lot more useful to
leave the 0 and 1 error codes only for the case where an argument is
not used.


I can understand that you guys want to follow the standard (after all,
if a program follows the standard, it is not a bug in the program by
definition), but to me this seems like a bug in the standard itself,
as explained.

Unfortunately, I'm just speaking as an end user here. If nothing I say
about this makes sense to you, ok, do nothing, but it would be
wonderdul if you, as the authors, would ask the standard to be
clarified or modified, as you are in a much better position to do so.

Thanks.
