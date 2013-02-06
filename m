Return-Path: ingenit@zoho.com
Message-ID: <51129723.3010102@zoho.com>
Date: Wed, 06 Feb 2013 18:47:15 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: Re: [PATCH 1/3] a pointer should not be compared to zero [coccinelle]
References: <1359578005-13427-1-git-send-email-kerolasa@iki.fi> <510D99FD.8060608@zoho.com> <20130206110006.GD24476@x2.net.home>
In-Reply-To: <20130206110006.GD24476@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 06/02/13 12:01, Karel Zak wrote:
> On Sat, Feb 02, 2013 at 11:58:05PM +0100, Ángel González wrote:
>> On 30/01/13 21:33, Sami Kerola wrote "a pointer should not be compared
>> to zero":
>>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
>  Applied, thanks.
> 
>> Why not? It is perfectly legal.
>> See http://www.c-faq.com/null/null2.html
> 
>  It's usually legal from compiler or C standard point of view, but
>  it's horrible coding style manner.

I agree it's nicer, but if it's just for coding style I would have
expected a commit message about that, not "should not be compared".


>  For example:
>     http://lwn.net/Articles/93574/

Funny Linus remarks :)
