Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbaJIMVm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Oct 2014 08:21:42 -0400
Date: Thu, 9 Oct 2014 14:21:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Adam Sampson <ats@offog.org>
Cc: Thorsten Glaser <tg@mirbsd.org>, util-linux@vger.kernel.org
Subject: Re: script from 2.25.1 may be broken (hangs)
Message-ID: <20141009122123.GG8057@x2.net.home>
References: <loom.20141009T001730-172@post.gmane.org>
 <y2a7g09a50k.fsf@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <y2a7g09a50k.fsf@cartman.at.offog.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 09, 2014 at 11:53:15AM +0100, Adam Sampson wrote:
> Thorsten Glaser <tg@mirbsd.org> writes:
> 
> > $ script -qc './test.sh -v' </dev/null 2>&1 | tee log
> 
> For me, this doesn't hang, but it does exit before test.sh is actually
> finished. Here's a simpler example that does the same thing:
> 
> $ cat simpler.sh
> #!/bin/sh
> echo one
> sleep 2
> echo two
> $ script -c './simpler.sh'
> Script started, file is typescript
> one
> two
> Script done, file is typescript
> $ script -c './simpler.sh' </dev/null
> Script started, file is typescript
> one
> Script done, file is typescript
> 
> The "wait for children" code at the end of doinput looks suspicious to
> me -- finish() doesn't actually block, as the comment implies, just

 hmm.. because WNOHANG, it seems we need a one function for signal
 handler (with WNOHANG) and another function for the real program
 termination (without WNOHANG).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
