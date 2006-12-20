Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964941AbWLTI5U (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 03:57:20 -0500
Date: Wed, 20 Dec 2006 09:57:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: kill (was: Re: util-linux: orphan)
Message-ID: <20061220085706.GH5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 20, 2006 at 01:42:13AM -0500, Albert Cahalan wrote:
> Karel Zak writes:
> 
> >I've originally thought about util-linux upstream fork,
> >but as usually an fork is bad step. So.. I'd like to start
> >some discussion before this step.
> ...
> >after few weeks I'm pleased to announce a new "util-linux-ng"
> >project. This project is a fork of the original util-linux (2.13-pre7).
> 
> Well, how about giving me a chunk of it? I'd like /bin/kill please.

 We can think about it. I'm not sure with this kind of changes in the
 next 2.13 release. That release should be more about bug fixes and
 code stabilisation. 
 
 I'd like to do some consolidation in 2.14. I also need explore why
 RHEL/FC uses the kill command from util-linux rather that from
 procps. And Suse and Debian?

 Frankly, things around proc/ need more changes. There is area for huge
 improvements. There is also the psmisc project where community duplicate 
 effort and code. 
 
 My dream is stable and useful libproc (with python and perl binding) 
 and one or two packages based on this library. (Yes we have libproc
 in procps, but this library is completely useless outside procps...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
