Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:62768 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161149AbWLUCcz (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 21:32:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2872207nfa
        for <util-linux-ng@vger.kernel.org>; Wed, 20 Dec 2006 18:32:54 -0800 (PST)
Message-ID: <787b0d920612201832p2549d1e3qba9e4430134997a7@mail.gmail.com>
Date: Wed, 20 Dec 2006 21:32:53 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Karel Zak" <kzak@redhat.com>
Subject: Re: kill (was: Re: util-linux: orphan)
Cc: "List util-linux-ng" <util-linux-ng@vger.kernel.org>
In-Reply-To: <20061220211224.GL5971@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz>
	 <787b0d920612200833h38cd9023ufb1ebba87d4b36ec@mail.gmail.com>
	 <20061220211224.GL5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/20/06, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Dec 20, 2006 at 11:33:53AM -0500, Albert Cahalan wrote:

> > I started a move toward that, adding symbol versioning and such.
>
>  We're ***off-topic***... but I think the problem with libproc is not about
>  versioning. I see there (exported) global variables, functions like
>
>  void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict
>          csys, jiff *restrict cide, jiff *restrict ciow, jiff *r unsigned long
>          *restrict pin, unsigned long *restrict pout, unsigned long *restrict
>          s_in, unsigned long *restrict unsigned *restrict intr, unsigned
>          *restrict ctxt, unsigned int *restrict running, unsigned int
>          *restrict blocked, unsigned int *restrict btime, unsigned int
>          *restrict processes)
>
>  API is not uniform ("esprit de corps") and many others things which
>  looks really ugly.

That function illustrates the problem nicely. It didn't always have
so many parameters. Perhaps some day it will use a struct, but
that would make no difference whatsoever. Every time a new data
item gets added, yet another implementation would need to be
created. Probably the old ABI versions would be wrappers around
the latest ABI.

So then, in time, we get 15 different versions of that function.
Having multiple versions is gross. Worse yet, there isn't any
documented and/or legitimate way to eliminate the old versions.
Symbol versioning nests, or at least it does in all documentation.
The latest version thus requires all older versions.

> > old interfaces gradually and drop them one by one. If you know of
> > a low-bloat high-performance way to make things work, tell me.
>
>  I think the best docs about shared libs:
>
>     http://people.redhat.com/drepper/dsohowto.pdf

Of course I read that. It's very sad that that is the best
documentation to be found. Really, it's dreadful.

It doesn't really deal with the practical problems of
maintaining an ABI in the face of volatile requirements.

Also, what if my ABI contains a struct defined by glibc?
The glibc maintainers could change the struct. This is
outside of my control, and may thus break any versioning
that I may do. Even binutils can do this; the GNU hash
stuff in Fedora Core 6 is a perfect example.

There is something far worse than not having a stable ABI.
There is PRETENDING to have a stable ABI, or IMAGINING
that there is a stable ABI.

BTW, any such ABI would need regression tests.
