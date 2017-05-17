Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: versioning
Date: Wed, 17 May 2017 10:42:53 +0200
Cc: util-linux@vger.kernel.org
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
In-Reply-To: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201705171042.53414.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 17 May 2017, Karel Zak wrote:
>  Hi,
>
>  Sami has good point on IRC... do we really want to continue with the
>  current versioning schema? Now we use:
>
>     v2.xx[.y]
>
>  I don't expect v3 or v4, so the prefix v2 does not provide any
>  information... and the 'xx' ('30' now) is already large number.
>
>  Suggestions:
>
>  1) do nothing; nobody cares and v2.31 looks good
>
>  2) remove '2' from the version:
>
>         major release:  v31
>         update release: v31.1

I don't see why v31 would be better than v3? I always appreciate if 
there are no gaps in version numbers. So v31 should be released after 
v30 ;)

>
>  3) <your suggestion>?
>

I would prefer either v2.31 or v3.1.

v3 just to avoid big numbers. But could also be a hint regarding the 
minimum supported/tested kernel version. I believe that we have already 
a few incompatibilities for kernel <2.6.32. Maybe we could cleanup our 
code, only supporting kernel >=3.1.

cu,
Rudi

>  Note that for v2.30 is to late to do any change in version numbers
>  (we need changes in our libraries and I have to update some my
> scripts).
>
>     Karel
