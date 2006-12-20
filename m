Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mail.station1.mxsweep.com ([212.147.136.149]:3079 "EHLO
	blue.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964977AbWLTKG3 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 20 Dec 2006 05:06:29 -0500
Received: from blue.mxsweep.com (127.0.0.1) by blue.mxsweep.com (MlfMTA v3.2r1b3) id hh45ni0171sv for <util-linux-ng@vger.kernel.org>; Wed, 20 Dec 2006 10:07:48 +0000 (envelope-from <P@draigBrady.com>)
Message-ID: <45890A78.1030105@draigBrady.com>
Date: Wed, 20 Dec 2006 10:03:36 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Albert Cahalan <acahalan@gmail.com>,
        List util-linux-ng <util-linux-ng@vger.kernel.org>,
        "Alfred M. Szmidt" <ams@gnu.org>, Evan Hunt <ethanol@armory.com>
Subject: Re: kill
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz>
In-Reply-To: <20061220085706.GH5971@petra.dvoda.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Dec 20, 2006 at 01:42:13AM -0500, Albert Cahalan wrote:
>> Karel Zak writes:
>>
>>> I've originally thought about util-linux upstream fork,
>>> but as usually an fork is bad step. So.. I'd like to start
>>> some discussion before this step.
>> ...
>>> after few weeks I'm pleased to announce a new "util-linux-ng"
>>> project. This project is a fork of the original util-linux (2.13-pre7).
>> Well, how about giving me a chunk of it? I'd like /bin/kill please.

We definitely need less version of kill:

ubuntu: $ dpkg -S `which kill`
procps: /bin/kill

fedora: $ rpm -qf `which kill`
util-linux-2.12p-9.3

fedora: $ type kill
kill is a shell builtin

$ tar tzf coreutils-6.2.tar.gz | grep kill
coreutils-6.2/src/kill.c
coreutils-6.2/man/kill.1
coreutils-6.2/man/kill.x


>  We can think about it. I'm not sure with this kind of changes in the
>  next 2.13 release. That release should be more about bug fixes and
>  code stabilisation. 

agreed.

>  
>  I'd like to do some consolidation in 2.14. I also need explore why
>  RHEL/FC uses the kill command from util-linux rather that from
>  procps. And Suse and Debian?

On a similar note, there are utils in util-linux[-ng] that are
not specific to linux (like look, cal etc.)
There has been the proposal for a new miscutils project
on the coreutils list: http://lists.gnu.org/archive/html/bug-coreutils/2006-11/msg00086.html
for which I am the proposed maintainer of.
Possibly some of these non specific linux utils could be moved there?

cheers,
Pádraig.
