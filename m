Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36106 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030357AbWLTVM2 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 16:12:28 -0500
Date: Wed, 20 Dec 2006 22:12:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: kill (was: Re: util-linux: orphan)
Message-ID: <20061220211224.GL5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <787b0d920612200833h38cd9023ufb1ebba87d4b36ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <787b0d920612200833h38cd9023ufb1ebba87d4b36ec@mail.gmail.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 20, 2006 at 11:33:53AM -0500, Albert Cahalan wrote:
> SuSE is probably dying, having made a deal with some bastards
> who've screwed every business "partner" they've ever had.

 Please! ... our business is not talk about Novell's business.

> > My dream is stable and useful libproc (with python and perl binding)
> > and one or two packages based on this library. (Yes we have libproc
> > in procps, but this library is completely useless outside procps...).
> 
> I started a move toward that, adding symbol versioning and such.

 We're ***off-topic***... but I think the problem with libproc is not about
 versioning. I see there (exported) global variables, functions like 
 
 void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict
         csys, jiff *restrict cide, jiff *restrict ciow, jiff *r unsigned long
         *restrict pin, unsigned long *restrict pout, unsigned long *restrict
         s_in, unsigned long *restrict unsigned *restrict intr, unsigned
         *restrict ctxt, unsigned int *restrict running, unsigned int
         *restrict blocked, unsigned int *restrict btime, unsigned int
         *restrict processes)
 
 API is not uniform ("esprit de corps") and many others things which
 looks really ugly. 

> old interfaces gradually and drop them one by one. If you know of
> a low-bloat high-performance way to make things work, tell me.

 I think the best docs about shared libs:

    http://people.redhat.com/drepper/dsohowto.pdf

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
