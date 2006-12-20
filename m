Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42599 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964983AbWLTKqK (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 05:46:10 -0500
Date: Wed, 20 Dec 2006 11:45:47 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: Albert Cahalan <acahalan@gmail.com>,
        List util-linux-ng <util-linux-ng@vger.kernel.org>,
        "Alfred M. Szmidt" <ams@gnu.org>, Evan Hunt <ethanol@armory.com>
Subject: Re: kill
Message-ID: <20061220104547.GJ5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <45890A78.1030105@draigBrady.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 20, 2006 at 10:03:36AM +0000, Pádraig Brady wrote:
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

 Yes.  ;-)

> >  I'd like to do some consolidation in 2.14. I also need explore why
> >  RHEL/FC uses the kill command from util-linux rather that from
> >  procps. And Suse and Debian?
> 
> On a similar note, there are utils in util-linux[-ng] that are
> not specific to linux (like look, cal etc.)
> There has been the proposal for a new miscutils project
> on the coreutils list: http://lists.gnu.org/archive/html/bug-coreutils/2006-11/msg00086.html
> for which I am the proposed maintainer of.
> Possibly some of these non specific linux utils could be moved there?

 Well, good topic for release 2.14

 No problem move things from one to an other project if the
 destination project is stable and maintained. I'm not sure with a
 *new* project. 
 
 It's attractive start a new project, but everyday I fight with
 unmaintained or really badly maintained things. People should be less
 egoistic when they think about new projects. I think one huge
 maintained project is better than few small unmaintained projects.

 I'd like to be careful with this thing.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
