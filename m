Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 11:08:29 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/16] whereis: tell when mandatory option is missing
In-Reply-To: <20150224094007.GE19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011106350.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-2-git-send-email-kerolasa@iki.fi> <20150224094007.GE19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:41:31PM +0000, Sami Kerola wrote:
> >  misc-utils/whereis.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
>  Benno is right, see construct_dirlist_from_argv(), the dir list is
>  terminated by arbitrary option, it checks for '-'.
> 
>  The expected use-case is "<dirlist> <search-restriction> <pattern>",
>  for example:
> 
>     whereis -M /usr/share/man/man1 -m ls

Hi Benno & Karel,

I see, most of the options has to flick the opt_f_missing. Here is updated 
version of the change.

https://github.com/kerolasa/lelux-utiliteetit/commit/ada8f7f0b253a031936519f7953629d701832444

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
