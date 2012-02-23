Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41391 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab2BWSEh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 Feb 2012 13:04:37 -0500
Received: by daed14 with SMTP id d14so1525430dae.19
        for <util-linux@vger.kernel.org>; Thu, 23 Feb 2012 10:04:37 -0800 (PST)
Subject: Re: [PATCH 0/4] Add functions to the fsck wrapper to improve
 standalone operation.
From: Frank Mayhar <fmayhar@google.com>
To: =?ISO-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
In-Reply-To: <4F3DC11E.9040205@draigBrady.com>
References: <1328648733.11787.13.camel@peace.lax.corp.google.com>
	 <4F3BBA72.90902@draigBrady.com>
	 <CAKp+pw1irqkv7JBRWLHYWsLzCzRb6GN44C-6r3x4ZnUbUL8nuQ@mail.gmail.com>
	 <4F3BD80B.7090409@draigBrady.com>  <20120215174258.GC15572@x2.net.home>
	 <1329423426.4310.16.camel@peace.lax.corp.google.com>
	 <4F3DC11E.9040205@draigBrady.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Feb 2012 10:04:34 -0800
Message-ID: <1330020274.29515.30.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sorry for the belated reply, I got bad news from the oncologist recently
and have been a bit distracted.

On Fri, 2012-02-17 at 02:53 +0000, Pádraig Brady wrote:
> On 02/16/2012 08:17 PM, Frank Mayhar wrote:
> > We have to do special stuff if an fsck fails for a particular file
> > system.  Without running each fsck individually (something I want to
> > avoid for a number of reasons),
> 
> please give a couple as this is a crucial point

One, memory use.  Running each fsck individually means we use more
memory than allowing fsck itself to do the parallelization.  Not a _lot_
more memory, certainly, but under certain conditions it can become
significant (e.g. when running in a cgroup, among other things).

Two, tracking multiple parallel instances of fsck from a shell script is
a lot less straightforward than allowing the fsck wrapper itself to do
so.  The fsck wrapper already has the code to do the tracking, the
functions I added simply build on that code.  Writing a shell script to
do the same thing (particularly when one has to handle fsck errors
specially, as we do) is redundant, potentially error-prone and (the real
kicker as far as I'm concerned) hard to maintain.  It also (three) adds
complexity to the start-up scripts which are already plenty complex
_and_ it adds a dependency on that script which would not exist
otherwise.  (That is, to do a "proper" fsck by hand one would either
have to set up the environment properly so that the script doesn't fall
over, or provide _another_ script that can be run independently.  It's a
_lot_ easier to be able to just type "fsck".)

Adding a way to allow special handling to fsck itself is easy (the code
is really straightforward), reduces the fsck footprint and reduces
complexity, making things easier to maintain.
-- 
Frank Mayhar
fmayhar@google.com

