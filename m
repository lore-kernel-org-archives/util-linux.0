Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170830073205.h4czf7hv5nrnwtcd@ws.net.home>
References: <20170828203813.12698-1-kerolasa@iki.fi> <20170830073205.h4czf7hv5nrnwtcd@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 30 Aug 2017 10:09:41 +0100
Message-ID: <CAG27Bk0OvYHEq29aSCHkSSBcMjfDWX=D-9CurLoN9c2DxyPXTQ@mail.gmail.com>
Subject: Re: [PATCH] chsh: remove local /etc/shells parsing in favour of getusershell(3)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On 30 August 2017 at 08:32, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Aug 28, 2017 at 09:38:13PM +0100, Sami Kerola wrote:
>> Less code, less bugs.  And if there are bugs at least share them with all
>> other programs that use getusershell(3) from libc.
>
> Is it portable? ulibC etc.. ?

It is available in uClib
https://git.uclibc.org/uClibc/tree/libc/unistd/usershell.c

Also in musl, but strangely in legacy directory
https://git.musl-libc.org/cgit/musl/tree/src/legacy/getusershell.c

But I guess the best option is to add check to configure.ac and write
util-linux getusershell() fallback when it is not available. I'll do that
sometime soonish, about before end of the week.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
