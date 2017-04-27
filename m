Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170424104218.uouuogsxb5m356yi@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi> <20170424104218.uouuogsxb5m356yi@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 27 Apr 2017 22:18:12 +0100
Message-ID: <CAG27Bk3D_iU5BGs5VSutX9jZE2aPQVo4sYxmXdh+azeeoqk-MQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] pull: various change, some options related
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 24 April 2017 at 11:42, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 23, 2017 at 09:58:11PM +0100, Sami Kerola wrote:
>> The chfn and chsh is about usability provided by readline().  I did not add
>> #ifdev HAVE_LIBREADLINE and make none libreadline compilation to work
>> because it looks like sfdisk is doing the same.  Let me know if fallback
>> should be made to work.
>
> Are you sure?
>
> $ grep HAVE_LIBREADLINE disk-utils/sfdisk.c
> #ifdef HAVE_LIBREADLINE
> #ifdef HAVE_LIBREADLINE
> #ifdef HAVE_LIBREADLINE
> #ifdef HAVE_LIBREADLINE
> #ifndef HAVE_LIBREADLINE
>
>  ... we want to be independent on libreadline of course and it's also
>  important to keep the utils usable when stdin is not terminal.

Let me look again, 8-/  Oh yes, I should go to specssavers. Corrected
version below.

https://github.com/kerolasa/lelux-utiliteetit/commit/9d647e4e3010b9214338f2a1d9e78e19a5358981

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
