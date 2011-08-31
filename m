Return-Path: maks@vostochny.stro.at
Date: Wed, 31 Aug 2011 15:17:15 +0000
From: maximilian attems <max@stro.at>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] raw: fix shadowing of minor function
Message-ID: <20110831151715.GI1781@vostochny.stro.at>
References: <1314637175-30646-1-git-send-email-max@stro.at>
 <20110830095412.GQ1855@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110830095412.GQ1855@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 30, 2011 at 11:54:12AM +0200, Karel Zak wrote:
> On Mon, Aug 29, 2011 at 06:59:35PM +0200, maximilian attems wrote:
> > Noticed while compiling against klibc:
> > raw.c: In function ‘query’:
> > raw.c:219:16: error: called object ‘minor’ is not a function
> > 
> > Rename variable from minor to minor_raw.
> 
> raw.c: In function ‘query’:
> raw.c:241:16: error: ‘minor’ undeclared (first use in this function)
> 
> Fixed, applied, thanks.
> 

uups.
thanks for fixing up!

-- 
maks
