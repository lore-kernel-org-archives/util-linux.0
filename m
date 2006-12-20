Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:59680 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbWLTQ6E convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 11:58:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2291290uga
        for <util-linux-ng@vger.kernel.org>; Wed, 20 Dec 2006 08:58:03 -0800 (PST)
Message-ID: <787b0d920612200858w16a1097fs28951bd8008a50a@mail.gmail.com>
Date: Wed, 20 Dec 2006 11:58:02 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "=?ISO-8859-1?Q?P=E1draig_Brady?=" <P@draigbrady.com>
Subject: Re: kill
Cc: "Karel Zak" <kzak@redhat.com>,
        "List util-linux-ng" <util-linux-ng@vger.kernel.org>,
        "Alfred M. Szmidt" <ams@gnu.org>, "Evan Hunt" <ethanol@armory.com>
In-Reply-To: <45890A78.1030105@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz>
	 <45890A78.1030105@draigBrady.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/20/06, Pádraig Brady <P@draigbrady.com> wrote:
> Karel Zak wrote:
> > On Wed, Dec 20, 2006 at 01:42:13AM -0500, Albert Cahalan wrote:
> >> Karel Zak writes:
> >>
> >>> I've originally thought about util-linux upstream fork,
> >>> but as usually an fork is bad step. So.. I'd like to start
> >>> some discussion before this step.
> >> ...
> >>> after few weeks I'm pleased to announce a new "util-linux-ng"
> >>> project. This project is a fork of the original util-linux (2.13-pre7).
> >> Well, how about giving me a chunk of it? I'd like /bin/kill please.
>
> We definitely need less version of kill:
>
> ubuntu: $ dpkg -S `which kill`
> procps: /bin/kill
>
> fedora: $ rpm -qf `which kill`
> util-linux-2.12p-9.3
>
> fedora: $ type kill
> kill is a shell builtin
>
> $ tar tzf coreutils-6.2.tar.gz | grep kill
> coreutils-6.2/src/kill.c
> coreutils-6.2/man/kill.1
> coreutils-6.2/man/kill.x

Hey, you left out the bsdutils kill command! That was what
Debian was using prior to the procps one.

> >  We can think about it. I'm not sure with this kind of changes in the
> >  next 2.13 release. That release should be more about bug fixes and
> >  code stabilisation.

Don't try it unless you have a complete test suite.

I'm seriously NOT kidding. Don't try it without a test suite.
This is not a project to be fucking up.

You even have something going against you: there is no
one person who really knows 100% of the code. You're in
a heap of trouble if you start putting in your favorite random
patch sets. You have no clue what you'll be breaking.

I had enough troubles with my own code prior to writing a
huge collection of regression tests. I changed my ways
after the procps release that failed to show processes
whose PID started with a "3". Once you have regression
tests, you can rip up the code with far less fear. Writing
the tests is also a good way to find bugs and an excellent
way to get yourself _really_ familiar with the code. Before
you modify code, always be sure you have test coverage
of anything even remotely related.

> On a similar note, there are utils in util-linux[-ng] that are
> not specific to linux (like look, cal etc.)

I have a "watch" command in procps that I wouldn't mind
getting rid of. It needs updating to be tolerant of color
escape sequences and maybe stuff like double-wide and
combining characters.

> There has been the proposal for a new miscutils project
> on the coreutils list: http://lists.gnu.org/archive/html/bug-coreutils/2006-11/msg00086.html
> for which I am the proposed maintainer of.
> Possibly some of these non specific linux utils could be moved there?

Gee, if we all grab a chunk of util-linux, then there isn't
any need for a util-linux project at all. :-)

Try asking Theodore Ts'o if he'd mind the fs-related stuff.
He's responsible. His ext2/3/4 test suite is why e2fsck
has such high quality.
