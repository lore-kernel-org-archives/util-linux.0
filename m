Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35795 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbF0IU7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Jun 2015 04:20:59 -0400
Received: by wiga1 with SMTP id a1so33951065wig.0
        for <util-linux@vger.kernel.org>; Sat, 27 Jun 2015 01:20:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <E1Z8e57-0003js-1r@bb>
References: <E1Z8e57-0003js-1r@bb>
Date: Sat, 27 Jun 2015 09:20:58 +0100
Message-ID: <CAG27Bk1qdxbFJNGVbPezFeKJME2pLHpAgDzOkDkGzT82CtE6kg@mail.gmail.com>
Subject: Re: [PATCH] wall: Print time and date (rather than just time) in wall banner
From: Sami Kerola <kerolasa@iki.fi>
To: Dave Rutherford <dave@evilpettingzoo.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27 June 2015 at 01:34, Dave Rutherford <dave@evilpettingzoo.com> wrote:
> This is a simple change to print the date and time in the wall banner.
> Previously just the time was printed.  This made more sense during the era
> of scarce and/or real terminals with interactive sessions of brief usage,
> when a terminal was likely to be attended, but makes less sense in the era
> of long-lived x-terminals, screen sessions, and so forth.  The latter may
> be left open for days or weeks at a time, and returning to one it may no
> longer be obvious just when a wall message was sent.  This can be relevant.
>
> This adds the seconds and the date (locale-appropriate format) to the
> wall banner, if any.
>
> Regards,
>    Dave Rutherford <dave@evilpettingzoo.com>
>
>
> $ diff -u term-utils/wall.c.orig term-utils/wall.c
> --- term-utils/wall.c.orig      2015-06-25 04:31:10.957160529 -0400
> +++ term-utils/wall.c   2015-06-26 01:45:04.150729302 -0400
> @@ -238,8 +238,9 @@
>                 sprintf(lbuf, _("Broadcast Message from %s@%s"),
>                               whom, hostname);
>                 fprintf(fp, "%-79.79s\007\007\r\n", lbuf);
> -               sprintf(lbuf, "        (%s) at %d:%02d ...",
> -                             where, lt->tm_hour, lt->tm_min);
> +               cnt = sprintf(lbuf, "        (%s) at ", where);
> +               mbuf = lbuf + cnt;
> +               strftime(mbuf, 79-cnt, "%T %x ...", lt);
>                 fprintf(fp, "%-79.79s\r\n", lbuf);
>         }
>         fprintf(fp, "%79s\r\n", " ");

Hi Dave,

It seems your patch is wrote using rather old util-linux source.  The
code segment in question has got at least one change[1], that makes
banner to be sysvinit compatible.  Banner now uses a date string similar
to date(1) default output, and it tends get truncated[2].  While back I
thought splitting the banner to multiple lines might be good idea, but
the wat I proposed the change did not satisfy review process[3].

Problem seems to be that the current header format simply does not have
enough room for all the information, and no-one has come up with a good
idea what would be better alternative format.  Maybe the later has not
been thought too much, and most certainly there has not been proposals
for alternative(s).

That said now when everything is turning to json, maybe header and
message should be json as well.  Something like:

{
  "title": "Broadcast message"
  "from": "foobar@example.com"
  "tty": "pts/2"
  "date": "2015-06-27T09:18:36+0100"
  "message": "the stuff users write"
}

[1] https://github.com/karelzak/util-linux/commit/d81c30553f4fb49173d38f69edff4b0b67a18b65
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=682778
[3] http://marc.info/?l=util-linux-ng&m=140661986032132&w=2

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
