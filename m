Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbaHFIQK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Aug 2014 04:16:10 -0400
Date: Wed, 6 Aug 2014 10:16:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
Message-ID: <20140806081602.GG19820@x2.net.home>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
 <2423860.9OdLEsNW7s@vapier>
 <CAG27Bk2OosZoo=XAGy+2Ld-pxAbTzivhr=cXE4S8FJtVzPnwAA@mail.gmail.com>
 <1946062.6JF60ZCY1D@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1946062.6JF60ZCY1D@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 04, 2014 at 03:31:13AM -0400, Mike Frysinger wrote:
> On Sun 03 Aug 2014 21:50:33 Sami Kerola wrote:
> i think there should be more.  i find them more readable, clearer intent, and 
> harder to screw up.  whereas passing around 0/1 everywhere gets funky (and i 
> think the code looks funky already).
> 
> > util-linux> git grep -l 'bool '
> > lib/mbsalign.c
> > login-utils/su-common.c
> > sys-utils/hwclock-cmos.c
> > sys-utils/hwclock.c
> > sys-utils/nsenter.c
> > tests/ts/login/logindefs
> > 
> > And question about bool is asked before.
> > 
> > http://marc.info/?l=util-linux-ng&m=135817763904699&w=2
> 
> it's a little hard to tell if it was meant generally or that specific case.  
> but if Karel prefers they not be used, then the codebase should reflect that.

I don't have strong opinion against 'bool', but I personally don't use
it. Well, exception are public library APIs, where the bool type is
mistake IMHO. 

The 'bool' type is gray C zone in some cases.

        slcurses.h:#define bool int
        python2.7/asdl.h:typedef enum {false, true} bool;

        tirpc/rpc/types.h:typedef int32_t bool_t;
        ncurses.h:#define bool NCURSES_BOOL
        notmuch.h:typedef int notmuch_bool_t;

 .. or bool, true and false are macros and bool expands to build-in C99 
 _Bool type or it's keyword in C++, etc.


For me "func(int isbar)" has the same readability as "func(bool bar)"
and in structs is always better to use bit fields (arrays).

> > The question was never answered, but if I should guess the idea in
> > util-linux is same as what Linus said should be done in kernel.
> > 
> > https://lkml.org/lkml/2013/8/31/138

Thanks, I have never read this, but he is right :-)

It seems that it's nothing unusual that people fight with bool in C:
http://www.lysator.liu.se/c/c-faq/c-8.html
http://stackoverflow.com/questions/25461/interfacing-with-stdbool-h-c
https://www.gnu.org/software/gnulib/manual/html_node/stdbool_002eh.html

And I don't think that codebase should reflect all my opinions :-)

Note, please, don't send patches that only remove/add bool -- common
sense is better than rules, if you believe that bool is the best thing
for your code than use it (if you cannot use bit fields, bool in
structs will be rejected). I'm going to use 'int' in my code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
