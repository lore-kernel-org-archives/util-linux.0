Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53671 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030425AbcCQMuw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 08:50:52 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Benno Schulenberg <bensberg@justemail.net>
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 13:50:43 +0100
Cc: "Util-Linux" <util-linux@vger.kernel.org>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com> <201603171135.19679.sweet_f_a@gmx.de> <1458215622.795504.551872786.40E5990C@webmail.messagingengine.com>
In-Reply-To: <1458215622.795504.551872786.40E5990C@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603171350.44094.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Benno Schulenberg wrote:
> On Thu, Mar 17, 2016, at 11:35, Ruediger Meier wrote:
> > On Thursday 17 March 2016, Benno Schulenberg wrote:
> > > When one hits ^C when the compilation phase of 'make check'
> > > finishes and the first tests start executing, the script prints
> >
> > I don't manage to reproduce that. How do you run make exactly (-j)?
>
> Just plain 'make' and 'make check'.
>
> > If I hit ctrl-C during compilation then the test script does not
> > start at all. Maybe there is a dependency problem and your tests
> > start before compilation is finished?
>
> No, I don't hit ^C during compilation but when it has finished,
> when that scary warning "Don't execute on production system!"
> has been printed and the first "OK"s have appeared.
>
> > Could you show us the test diffs?
> > $ find tests/diff/ -type f | xargs -r cat
>
> Attached.
> 
> > Maybe also warnings durning the test run (if any).
>
> Only the ipcs one prints warnings:
>
>          ipcs: mk-rm-msg                                     ... OK
>          ipcs: mk-rm-sem                                     ... OK
> ipcs: id 1048595 not found
> ipcs: id 1081363 not found
>          ipcs: mk-rm-shm                                     ...
> FAILED (ipcs/mk-rm-shm)

Thanks!

I have some guesses about "ipcs" and "fallocate" but some more 
questions:

1. Which kernel version?
2. Which file system? (findmnt -n -o FSTYPE -T tests/output)
3. Is /proc mounted?
4  grep "FALL" config.h

"swaplabel" test fails because it's using again fallocate. Maybe we 
should use dd/truncate instead to not test fallocate again.

The misc/ul failure is something about different ncurses (or 
terminals?). I know it from BSD. Don't know how this should be fixed in 
our test suite because I don't know much about ncurses stuff.

This is the plain diff:

--- tests/expected/misc/ul
+++ tests/output/misc/ul
@@ -1,3 +1,3 @@
-[1ma(B[mb[4mc[24m
+[1ma[m(Bb[4mc[24m


Interpreted by terminal both looks ok: "abc" with bold "a" and 
underlined "c". I sombody confirmes that both strings in the diff are 
totally ok on any system, then I would fix the test by using sed.

cu,
Rudi
