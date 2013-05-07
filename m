Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130506171622.GC9740@x2.net.home>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
	<1367520701-14962-9-git-send-email-kerolasa@iki.fi>
	<20130506171622.GC9740@x2.net.home>
Date: Tue, 7 May 2013 22:14:17 +0100
Message-ID: <CAG27Bk24+veeRDvg3ytkVZr2RJSWPgD5NOTym=GLBmxi_MqeVQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] lib: copy argmatch from gnulib
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 6 May 2013 18:16, Karel Zak <kzak@redhat.com> wrote:
> On Thu, May 02, 2013 at 07:51:33PM +0100, Sami Kerola wrote:
>> Both argmatch.h and argmatch.c are copied from gnulib.
>
>  Ah no... this is overkill, all we need is to parse three words.
>
>  I have updated lib/colors.c and dmesg.c to support color modes 'auto',
>  'never' and 'always'. Please, use it also in cal.c.

I thought there might be other uses to argmatch, but perhaps there
isn't. I changed the cal to use lib/colors.c argument parsing in
'cal-again' branch.

https://github.com/kerolasa/lelux-utiliteetit/commit/a33225e623b389e49d05b665104dcdef17e01502

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
