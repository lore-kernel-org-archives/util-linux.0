Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 2/2] hwclock: fix debug regression
To: kerolasa@gmail.com
References: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com>
 <975e1e00-fab6-e539-8b92-5388e33d7f16@gmx.com>
 <CAG27Bk2rXPKTyz=qEzns5zmJVUoWZUOa0KSHSTzD-1JWz9t70A@mail.gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2e56d19b-e8e8-576c-c071-92e181162512@gmx.com>
Date: Sun, 19 Nov 2017 15:09:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2rXPKTyz=qEzns5zmJVUoWZUOa0KSHSTzD-1JWz9t70A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 11/19/2017 04:51 AM, Sami Kerola wrote:
> That is probably fine as intermediate issue fix. It would be nice to
> see in longer term move to use debug.h. Then ctl->debug could
> be made single bit switch that turns on messaging it does, and
> all internal developer debugging stuff would be done with
> HWCLOCK_DEBUG_ bits. Assuming done this way adding more
> debuging levels is appropriate.
> 
> FYI login-utils/su-common.c is pretty good DBG example.
>

Hi Sami, I agree and so does Karel. He brought it up when I first
started contributing to ul back in 2014.

 https://marc.info/?l=util-linux-ng&m=141415311703313&w=2
 Karel Zak wrote:
>    Good point, then it would be better to [keep] --debug independent on
>    HWCLOCK_DEBUG=. 
>    
>    But I still think that for so complex tool like hwclock we need a 
>    real debug output for developers / bug reporters. The current --debug 
>    is more like --verbose we have in another tools.

It's on my radar and TODO list. I just do not know when I will get to
it. I've been trying to reduce the current 'debug' output as I go.
Hopefully that will make splitting verbose/debug and adding debug.h easier.
