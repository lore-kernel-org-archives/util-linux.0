Return-Path: util-linux-owner@vger.kernel.org
Received: from zproxy01.unex.es ([158.49.17.42]:48356 "EHLO zproxy01.unex.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933039AbbHIPOI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 9 Aug 2015 11:14:08 -0400
Date: Sun, 9 Aug 2015 17:04:42 +0200 (CEST)
From: Santiago Vila <sanvila@unex.es>
To: util-linux@vger.kernel.org, ah-util-linux@debian.org,
        794727@bugs.debian.org
cc: 794727-forwarded@bugs.debian.org
Subject: "mesg n" exits with error, even if the command is successful
Message-ID: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

[ Apologies if this is a FAQ ].

Debian has recently switched the "mesg" implementation from
the one in sysvinit to the one in util-linux.

We have found a subtle issue: The old mesg didn't have any error codes
at all. The new mesg (from util-linux) has the following error codes:

            0     Messages are allowed.

            1     Messages are not allowed.

           >1     An error has occurred.

The problem is that those error codes are in effect not only when
the mesg command is invoked alone:

mesg

but also when it's used with an argument:

mesg y
mesg n

This breaks the default /root/.profile which has a simple "mesg n" at
the end, so we will probably have to hide the error like this:

mesg n || true

but this is a little bit weird and I wonder how much people will have
to do this as well.

In Unix, usually, whenever I tell a command to do something, there is
only an error when the command is not able to do what I ask it to do.

In this case, however, the "mesg n" is succesful, as it is actually
able to disable write to the terminal, and yet it exits with an error.

I think this does not make much sense and would humbly propose that
the behaviour is changed so that error codes are only used when
the mesg is used alone, without any arguments.

Surely that a change like this might in theory break some scripts,
but let's see what kind of breakage we could expect:

* People who write this:

mesg y

will not need to change anything.

* People who write this:

mesg n || true

will finally be able to remove the "|| true" part. If they don't
remove the "|| true" part, nothing really bad will happen.

In fact, this could even improve things a little bit, as "mesg" alone
will fail if the mesg does not exist.

* People writing things like this:

if mesg 2> /dev/null; then
  echo mesg is y
else
  echo mesg is n
fi

which is where exit codes are actually useful, will not be affected at
all.

Of course one can always create a complex use case where a change in
exit codes would break the script, but I think those would be a very
small minority.

So: Would you please consider a change in mesg behaviour regarding
exit codes, so that "mesg n" does not gratuitously fail?

Thanks.
