Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60339 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755354Ab3HWLFB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 23 Aug 2013 07:05:01 -0400
Date: Fri, 23 Aug 2013 13:04:58 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 00/16] pull: additions recent to last(1) work, plus few
 small changes
Message-ID: <20130823110458.GA2560@x2.net.home>
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
> I thought the --fulltimes has not been released yet.
 
 Well, it's long option for -F which exists for years in sysvinit.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
