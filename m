Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:40342 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab1IUU0W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Sep 2011 16:26:22 -0400
Date: Wed, 21 Sep 2011 16:26:20 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Tim Pepper <tpepper@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libuuid clock.txt fd leaks
Message-ID: <20110921202620.GD4056@thunk.org>
References: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 21, 2011 at 09:58:21AM -0700, Tim Pepper wrote:
> The sourceforge.net link above includes a number of suggested options.
>  And there's also just the simple implementation option for
> get_clock() that doesn't have the fd as static much less TLS and
> opens/closes at each invocation.  That maybe comes with a noticable
> performance hit for some types of users and I don't really know the
> full list of possible use cases here...do some people really need that
> high performance uuid generation?  Either way, the "right" general
> solution isn't immediately obvious to me so I thought I'd see what
> others here thought...

Part of the problem is that the uuid library was originally designed
non-thread-using libraries, and I originally was trying to force all
programs to link against -lpthread.  (Remember, libuuid as found in
e2fsprogs predates Linux having a standardized threads support, or any
threads support at all.)

Personally, I think threads are evil, and avoid them like the plague,
so I'm not up on the latest threads requirements, but at least at one
point, if a shared library used threads all of the programs that
called said shared library had to link against pthreads and #include
pthread.h, and have errno redefined, etc.  (Remember we need to worry
about making things work both for the static and shared linking case.)

So the reason why I put in THREAD_LOCAL was it was the simplest way to
avoid problems without having access to mutexes and without having to
drag in the whole posix threads mess and inflicting it on all of
libuuid's callers.

Unfortunately, it didn't occur to me that people would write programs
where they spawned jillions of threads and then abandon them, causing
the fd leak that would eventually kill the program.  (See my belief
that Posix Threads are evil.)

It may be that the right answer is to create a separate library which
is used for threading programs --- or develop a completely thread-safe
API for threaded progams, and keep the old API for
sane^H^H^H^Hsingle-threaded programs.

							- Ted
