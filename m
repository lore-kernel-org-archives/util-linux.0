Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965121AbWLTPBG (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 10:01:06 -0500
Subject: Re: kill
From: Ian Kent <ikent@redhat.com>
To: =?ISO-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Karel Zak <kzak@redhat.com>, Albert Cahalan <acahalan@gmail.com>,
        List util-linux-ng <util-linux-ng@vger.kernel.org>,
        "Alfred M. Szmidt" <ams@gnu.org>, Evan Hunt <ethanol@armory.com>
In-Reply-To: <45890A78.1030105@draigBrady.com>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz>  <45890A78.1030105@draigBrady.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Dec 2006 00:00:54 +0900
Message-Id: <1166626854.4264.6.camel@raven.themaw.net>
Mime-Version: 1.0
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2006-12-20 at 10:03 +0000, Pádraig Brady wrote:
> Karel Zak wrote:
> > On Wed, Dec 20, 2006 at 01:42:13AM -0500, Albert Cahalan wrote:
> >> Karel Zak writes:
> >>
> >>> I've originally thought about util-linux upstream fork,
> >>> but as usually an fork is bad step. So.. I'd like to start
> >>> some discussion before this step.
> >> ...
> >>> after few weeks I'm pleased to announce a new "util-linux-ng"
> >>> project. This project is a fork of the original util-linux (2.13-pre7).
> >> Well, how about giving me a chunk of it? I'd like /bin/kill please.
> 
> We definitely need less version of kill:
> 
> ubuntu: $ dpkg -S `which kill`
> procps: /bin/kill
> 
> fedora: $ rpm -qf `which kill`
> util-linux-2.12p-9.3
> 
> fedora: $ type kill
> kill is a shell builtin
> 
> $ tar tzf coreutils-6.2.tar.gz | grep kill
> coreutils-6.2/src/kill.c
> coreutils-6.2/man/kill.1
> coreutils-6.2/man/kill.x
> 

So the question is where should kill live.

And we could probably decide that if we had a quorum of down stream
maintainers on the list.

Anyone?

Ian


