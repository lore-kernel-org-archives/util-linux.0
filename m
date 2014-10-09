Return-Path: util-linux-owner@vger.kernel.org
Received: from auth.b.painless.aa.net.uk ([90.155.4.48]:51986 "EHLO
	auth.b.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbaJILYU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 Oct 2014 07:24:20 -0400
From: Adam Sampson <ats@offog.org>
To: Thorsten Glaser <tg@mirbsd.org>
Cc: util-linux@vger.kernel.org
Subject: Re: script from 2.25.1 may be broken (hangs)
References: <loom.20141009T001730-172@post.gmane.org>
Date: Thu, 09 Oct 2014 11:53:15 +0100
In-Reply-To: <loom.20141009T001730-172@post.gmane.org> (Thorsten Glaser's
	message of "Wed, 8 Oct 2014 22:25:38 +0000 (UTC)")
Message-ID: <y2a7g09a50k.fsf@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thorsten Glaser <tg@mirbsd.org> writes:

> $ script -qc './test.sh -v' </dev/null 2>&1 | tee log

For me, this doesn't hang, but it does exit before test.sh is actually
finished. Here's a simpler example that does the same thing:

$ cat simpler.sh
#!/bin/sh
echo one
sleep 2
echo two
$ script -c './simpler.sh'
Script started, file is typescript
one
two
Script done, file is typescript
$ script -c './simpler.sh' </dev/null
Script started, file is typescript
one
Script done, file is typescript

The "wait for children" code at the end of doinput looks suspicious to
me -- finish() doesn't actually block, as the comment implies, just
checks to see if any children have finished. Running Thorsten's command
under strace -f reveals:

[21180 is the script process running doinput, 21181 is running dooutput]
21180 write(4, "\x04", 1 <unfinished ...>
21180 <... write resumed> )             = 1
21180 poll([{fd=4, events=POLLIN}], 1, 100 <unfinished ...>
21180 <... poll resumed> )              = 1 ([{fd=4, revents=POLLIN}])
21180 poll([{fd=4, events=POLLIN}], 1, 100) = 1 ([{fd=4, revents=POLLIN}])
21180 poll([{fd=4, events=POLLIN}], 1, 100) = 1 ([{fd=4, revents=POLLIN}])
21180 poll([{fd=4, events=POLLIN}], 1, 100 <unfinished ...>
[lots more poll calls while other stuff happens in child processes]
21180 <... poll resumed> )              = 0 (Timeout)
21180 wait4(-1, 0x7fff47830c54, WNOHANG, NULL) = 0
21180 kill(21181, SIGTERM)              = 0

But at this point the child is still running. So it looks like doinput
isn't waiting for the child to exit correctly, when stdin has hit EOF
before the child has finished.

Thanks,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
