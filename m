Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62308 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab2FLIhA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jun 2012 04:37:00 -0400
Date: Tue, 12 Jun 2012 10:36:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Bertrand Jacquin <beber@meleeweb.net>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] require C99, add robustness and small fixes
Message-ID: <20120612083643.GA23991@x2.net.home>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
 <20120611094851.GA21893@x2.net.home>
 <20120611222938.GD25482@lemonhead.scabb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120611222938.GD25482@lemonhead.scabb>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 12, 2012 at 12:29:38AM +0200, Bertrand Jacquin wrote:
> # We might be on RHEL5 with a git checkout and so broken
> > > +  # autoconf. Check if CC is gcc and if it bails when given -std=gnu99.
> > > +  # If not, use that.  Yuck.
> > > +    if test "x$ac_cv_c_compiler_gnu" = "xyes"; then
> > > +       CC="$CC -std=gnu99"
> > > +       AC_RUN_IFELSE(
> > > +          [AC_LANG_PROGRAM([],[[
> > > +  return 0;
> > > +      ]])],
> > > +      [],
> > > +      [AC_MSG_ERROR([Could not find a C99 compatible compiler])])
> > > +    else
> > > +      AC_MSG_ERROR([Could not find a C99 compatible compiler])
> > > +    fi
> > > +  fi
> > > +fi
> > 
> >  AC_PROG_CC_C99 sounds really like a better solution, although I have
> >  autoconf 2.68 on Fedora 16 :-(
> 
> This is also present in autoconf-2.68 (lib/autoconf/c.m4:1360)

 It seems that AC_PROG_CC_C99 did not exist in Autoconf versions < 2.60.

 Anyway -- according to gnulib autoconf stuff -- there is an issue
 when AC_PROG_CC_C99 used together with AC_PROG_CC_STDC. For more
 details see gl_PROG_CC_C99 macro in coreutils or gnulib.

 I think we can exist without AC_PROG_CC_C99 for now, it seems better
 to explicitly enable some gcc warnings by UL_ADD_WARN() than add
 special workaround for AC_PROG_CC_C99, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
