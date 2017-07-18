Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: uuidparse: test fails on 32bit machines
Date: Tue, 18 Jul 2017 13:18:59 +0200
Cc: util-linux@vger.kernel.org,
 Sami Kerola <kerolasa@iki.fi>
References: <201707122115.01476.ruediger.meier@ga-group.nl> <201707181152.36773.sweet_f_a@gmx.de> <20170718104052.hhtwgjnlleahthmf@ws.net.home>
In-Reply-To: <20170718104052.hhtwgjnlleahthmf@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201707181319.00115.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 18 July 2017, Karel Zak wrote:
> On Tue, Jul 18, 2017 at 11:52:36AM +0200, Ruediger Meier wrote:
> > On Tuesday 18 July 2017, Karel Zak wrote:
> > > I have removed this dates from the test. The things are
> > > internally based on time_t (=long) and uint32_t. It does not make
> > > sense to use it for huge numbers.
> >
> > FYI I have created two travis testing branches in my private github
> > repo: https://travis-ci.org/rudimeier/util-linux/builds
> >
> >   travis-cc-test
> >      - testing many different compilers versions, even using
> > -Werror - gcc 4.6, 4.8, 5, 6 and 7
> >      - clang 3.4, 3.5, 3.9, 4.0 and 5.0
> >      - OSX xcode 6.4, 7.3, 8.3
> >
> >   travis-cc-test
> >      - testing 32bit build, -m32 -Werror
>
> Would be possible to enable build by date? I would be nice to run
> basic builds tests for each commit and enable some additional
> expensive builds for example every 10 days (or/and trigger the build
> by git tags, e.g. -rcN).

Yep, I will sort that out soon. Maybe creating another project "ul-test" 
which contains only test scripts. We could add even more checks there 
without polluting our main repo.

The tests should be invoked for interesting tags and once per week or 
something. To avoid unnecessary noise the extended tests should only 
run after at least our regular travis check finnished successfully.

cu,
Rudi
