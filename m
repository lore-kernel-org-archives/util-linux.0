Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140512121011.GH8951@x2.net.home>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
	<1399836409-7769-12-git-send-email-kerolasa@iki.fi>
	<20140512121011.GH8951@x2.net.home>
Date: Mon, 12 May 2014 15:53:29 +0100
Message-ID: <CAG27Bk15kOBNWt=T77H2EcdC1JhD7RLQD=89xcRdBmcfp+D2nQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] setterm: convert remaining magic values to symbolic references
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 12 May 2014 13:10, Karel Zak <kzak@redhat.com> wrote:
>  Please, use enum {} to group together things which have any relation,
>  otherwise use #define.
>
>  Fixed and merged.

Thanks for review & advice, I'll try to better changes in future.

>  Applied all patches in the patchset, thanks.

Which brings to me to generic FYI; I'll work more with setterm(1) this week.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
