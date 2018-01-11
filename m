Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63398 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753729AbeAKCA2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Jan 2018 21:00:28 -0500
Subject: Re: [v3 PATCH 00/11] Pull Request - changelog
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
Date: Wed, 10 Jan 2018 21:00:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/08/2018 05:21 AM, Karel Zak wrote:
> On Tue, Jan 02, 2018 at 09:53:18AM -0500, J William Piggott wrote:
> 
> I have no clue how many users care and read our ReleaseNotes, but
> important is that they have opportunity to do that and they have
> always time to adopt to changes. This is how I promised that this 
> project will be maintained. 

Your response here puzzled me, because I could not remember you ever
making a pre-announcement of this nature before.  For example when
hwclock's default output format was changed in v2.28 it didn't even make
the release highlights, let alone require a pre-change announcement.  I
did a quick grep and could not find a single instance of an advance
notification for this type of change.

> Thanks. I'll work on cal(1) in next days and use us much as possible
> from your patches.

I originally started a branch implemented for an advance notification; I
backported some of my later fixes from the v3 submission to it. The
resulting branch may be more to your liking:
  git@github.com:jwpi/util-linux.git 171225

The current v3 submission's branch is:
  git@github.com:jwpi/util-linux.git 171229

Both branches have an updated commit message for renaming --julian to
--ordinal, expanding on the rational for it:

    cal(1) is unique in that it uses both Julian and Gregorian calendar
    systems.  This causes a name collision with the --julian ordinal day
    option.

    Other commonly distributed code for POSIX-like systems do not share this
    problem because they all use the proleptic Gregorian calendar system
    exclusively; so they can get away with calling ordinal days 'julian' and
    using things like %j for formatting ordinal days.

    For cal(1) this ambiguity is problematic for developers, users,
    and for the implementation itself.

    There are no alternate names for the Julian calendar (system);
    alternates names for (ordinal) Julian calendar are: day-of-year,
    and ordinal. Ordinal being the preferred name:
     https://en.wikipedia.org/wiki/Julian_day#Terminology
     https://en.wikipedia.org/wiki/Ordinal_date

    To implement an exclusive Julian Calendar output for cal(1) it will need
    to use the name Julian, because there are no alternatives. Even for a
    mixed calendar output the dates earlier than the reform epoch need to be
    labeled and referred to as 'Julian'.

    Therefore, the current --julian option needs to be renamed to --ordinal.


While working on cal I discovered more things that are broken. I wanted
to include the fixes in this patch set, but I thought it would be too
much for this round. What I envision as the output to address these new
issues will also need to use the term Julian to represent the calendar
system.


