Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:41005 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030197AbWLTQdz (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 11:33:55 -0500
Received: by an-out-0708.google.com with SMTP id b33so662355ana
        for <util-linux-ng@vger.kernel.org>; Wed, 20 Dec 2006 08:33:54 -0800 (PST)
Message-ID: <787b0d920612200833h38cd9023ufb1ebba87d4b36ec@mail.gmail.com>
Date: Wed, 20 Dec 2006 11:33:53 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Karel Zak" <kzak@redhat.com>
Subject: Re: kill (was: Re: util-linux: orphan)
Cc: "List util-linux-ng" <util-linux-ng@vger.kernel.org>
In-Reply-To: <20061220085706.GH5971@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/20/06, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Dec 20, 2006 at 01:42:13AM -0500, Albert Cahalan wrote:

> > Well, how about giving me a chunk of it? I'd like /bin/kill please.
>
>  We can think about it. I'm not sure with this kind of changes in the
>  next 2.13 release. That release should be more about bug fixes and
>  code stabilisation.
>
>  I'd like to do some consolidation in 2.14. I also need explore why
>  RHEL/FC uses the kill command from util-linux rather that from
>  procps. And Suse and Debian?

RHEL/FC probably uses util-linux because that is older.

Debian uses procps.

SuSE is probably dying, having made a deal with some bastards
who've screwed every business "partner" they've ever had.

>  Frankly, things around proc/ need more changes. There is area for huge
>  improvements. There is also the psmisc project where community duplicate
>  effort and code.

Craig Small has talked about handing psmisc to me (he is also
the procps downstream for Debian) but we never really bothered.
I guess we're both fine with the minor duplication.

>  My dream is stable and useful libproc (with python and perl binding)
>  and one or two packages based on this library. (Yes we have libproc
>  in procps, but this library is completely useless outside procps...).

I started a move toward that, adding symbol versioning and such.
Then I realized that the combination of volatile kernel interfaces
and a stable libproc ABI just wouldn't work OK. The various structs
need to change when the kernel changes. Sure, symbol versioning
can "fix" that with one function for each ABI version, but that gets
terribly gross. I also didn't get any answers to my questions about
the version script format, particularly about methods to deprecate
old interfaces gradually and drop them one by one. If you know of
a low-bloat high-performance way to make things work, tell me.

Python itself seems to have versioning problems. The traditional
solution for scripting languages is to parse /bin/ps output; this is
perfectly reasonable because /bin/ps output is meant to be parsable.
In any case, the python interpreter is so buggy that you really
shouldn't be using it. (well, at least don't go anywhere near threads)
