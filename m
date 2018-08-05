Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:39172 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeHERKx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 5 Aug 2018 13:10:53 -0400
Date: Sun, 5 Aug 2018 11:05:57 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: util-linux@vger.kernel.org
Subject: Re: =?iso-8859-1?Q?Debian=B4?= =?iso-8859-1?Q?s?= change of "su" to
 the one in util-linux
Message-ID: <20180805150557.GC26138@thunk.org>
References: <1734536.DseMWcvaqb@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1734536.DseMWcvaqb@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 05, 2018 at 10:35:34AM +0200, Martin Steigerwald wrote:
> Now people say, including Debian maintainer of util-linux, in above NEWS 
> file entry: Using "su" without initializing new environment is a bad 
> idea and should never be done. For many reasons. However, nowhere I saw 
> these reasons actually mentioned. That is not enough for an informed 
> decision about it. I already opened a bug report for util-linux package 
> about no concrete reasons provided:
> 
> util-linux: su from util-linux: no reason why su without setting new 
> environment is bad idea
> https://bugs.debian.org/905478

The reason why preserving the environment across a su or a sudo can be
dangerous is that environments that are meant for use by an
unprivileged process might not be appropriate at all when running as
root.  There are lots of potential reasons why.  Here are some:

* The PATH might include the current directory, and so a script
  running as root might accidentally get the wrong/unexpected binary.
  This could lead to a security breach.

* Some environment variables might cause debugging or logging
  information to go to a specified file.  If a malicious user can
  control that environment variable, bad things can happen when the
  user is running as their own uid.  But even *worse* things can
  happen if the user is running as root.

So the basic security principle here is that scripts should be tested
and run using a single runtime environment.  If the Administrators
Alice and Bob have different environment variables set in their dot
files, then some administrative script might behave differenly
depending on whether Alice or Bob runs the script.  And worse, maybe
Charlie has a third set of environment variables that might cause the
script to do something catastrophically wrong.

So for that reason, it makes sense that a "sudo" or "su" command
should default to something safe.  

> And then: How to implement a backup script that needs root access for 
> most operations, but also requires access to SSH agent from a user 
> setup? Dig out the environment variables of the SSH agent myself? Let 
> the script run as a user and use "setprivs" that is mentioned as 
> recommend in the "su" manpage, yet is in a different package altogether 
> and not part of "util-linux".

You might want to look at the man page for sudo, and its configuration
files, especially sudoers.  It has a *huge* amount of fine-grained
controls over which environment variables should be reset, and which
ones which should be preserved, and whether or not a particular user
should be trusted to override environment variable processing on the
command line.

You can do this on a per-command or per-user basis, and you can do
things like allow some kinds to not require typing a password if it is
a "safe" thing for some set of users to do (perhaps with some controls
over time of day, or what environment variables can be manipulated,
etc.)

Cheers,

						- Ted
