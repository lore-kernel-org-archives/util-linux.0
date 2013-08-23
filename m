Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682Ab3HWLI1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 23 Aug 2013 07:08:27 -0400
Date: Fri, 23 Aug 2013 13:08:24 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 00/16] pull: additions recent to last(1) work, plus few
 small changes
Message-ID: <20130823110824.GA2969@x2.net.home>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
 <20130823100727.GB32136@x2.net.home>
 <CAG27Bk0vS1L=X9u+L9DyOe_LWnMLTMGX1BFqzg2B_ynBMpkMRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0vS1L=X9u+L9DyOe_LWnMLTMGX1BFqzg2B_ynBMpkMRw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 23, 2013 at 11:42:49AM +0100, Sami Kerola wrote:
> On 23 August 2013 11:07, Karel Zak <kzak@redhat.com> wrote:
> >>       last: use ISO 8601 time format for --fulltimes
> >
> >  This is not backwardly compatible. Not applied.
> >
> >  We need --fulltimes[=ctime|iso] or add --output=<list> and use lib/tt.c to
> >  generate output with arbitrary columns and formats.
> 
> I thought the --fulltimes has not been released yet. The backwards
> compatibility sounds good reason to do --output=<list>. I'll start
> working with that ~next week.
> 

 BTW, for things like --until / --present it would be nice to support
 relative times like we have for example in git:

    git log --since '1 day ago'

 The current YYYYMMDDHHMMSS sucks...

 I can image this for dmesg too (--since '1 hour ago').

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
