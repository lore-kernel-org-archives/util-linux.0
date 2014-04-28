Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140428065243.GJ2405@x2.net.home>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
	<1398629138-31718-2-git-send-email-kerolasa@iki.fi>
	<20140428065243.GJ2405@x2.net.home>
Date: Mon, 28 Apr 2014 09:42:12 +0100
Message-ID: <CAG27Bk3H0-Lp=vFQhw0mbeg7=rZS-0T+7BirPW1-cTSiCFN1sQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] include/xalloc: ensure arithmetics overflow cannot happen
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 28 April 2014 07:52, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 27, 2014 at 09:05:27PM +0100, Sami Kerola wrote:
>> The xrealloc() changes has the greatest change.  It splits the size and
>> multiplier arguments so that arithmetics overflow can be detected.  This
>> change is propagated to use of the function in other files.
>
>  I don't like it at all. The function realloc() has well know semantic
>  and arguments. We don't want to create parallel universe...
>
>  If you want something else "nmemb, size"  then introduce xrecalloc()
>  or so.. but don't use "realloc" name at all.
>
>> Additionally this change checks that size inputs for allocations are
>> never zero.  It is uncertain if in these cases abort() should be called
>> to get a core.
>
>  I don't think we need a different semantic than C standards.

Hi Karel,

Considering that, and other feedback, this patch is completely dead.
Please skip, and I'll have look if there is some value to add
xrecalloc() to xalloc.h.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
