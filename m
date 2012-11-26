Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab2KZKI2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Nov 2012 05:08:28 -0500
Date: Mon, 26 Nov 2012 11:08:22 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Andy Lutomirski <luto@amacapital.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add no_new_privs
Message-ID: <20121126100822.GA4224@x2.net.home>
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
 <50AFE72B.1010908@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50AFE72B.1010908@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 23, 2012 at 09:14:19PM +0000, Pádraig Brady wrote:
> On 11/23/2012 08:23 PM, Andy Lutomirski wrote:
> >---
> >
> >I'm not 100% sure this is appropriate for util-linux, but it seems useful.
> >
> >I've never written new programs for util-linux before, and I barely understand
> >autotools.  Feedback is welcome :)
> >
> >+no_new_privs \- run program with new_new_privs set
> 
> >+Sets the \fIno_new_privs\fP bit and then executes specified program.  With
> >+this bit set,
> >+.BR execve (2)
> >+will not grant new privileges.  For example, the setuid
> >+and setgid bits as well as file capabilities will not function.  This bit
> >+is inherited by child processes and cannot be unset.  See
> >+.BR prctl (2)
> >+and
> >+.IR Documentation/prctl/no_new_privs.txt
> >+in the Linux kernel source.
> 
> Seems very useful but a bit low level for a user command.
> How about a prctl(1) command or equivalent, that could
> accept that among other options to set.

 It would be nice to have prctl(1) implemented like prlimit(1), it
 means to support --set as well as --get operations.

  prctl --set-endian=big --set-name=foo

  prctl --pid 123    # return all --get-*

  prctl --get-name --pid 123

> I also notice the similar capsh(1) program for doing
> so with capabilities. Perhaps these could be merged
> to a setpriv(1) command or something for tweaking all
> these knobs before exec?

 hmm.. capsh(1) is libcap baby and it probably makes sense to maintain
 it on the same place like libcap.


 I guess that there will be never one super util to set all the
 possible properties (prlimit, personality, scheduler stuff, ....) and
 I personally don't see problem to type

   setarch x86_64 --addr-no-randomize \
   taskset --cpu-list 1,2 \
   prlimit --nofile=1024:4095 \
   nice -20 \
   <myprog>


   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
