Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57010 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163418AbdEXKC5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 May 2017 06:02:57 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: versioning
Date: Wed, 24 May 2017 12:02:43 +0200
Cc: Karel Zak <kzak@redhat.com>,
        "util-linux" <util-linux@vger.kernel.org>
References: <20170517210953.dskdxcr3rdmbtvgs@ws.net.home> <20170523080513.3yhhfzlmnyqoovpd@ws.net.home> <614d0e03-6baf-861b-8636-71c07443b3b6@gmx.com>
In-Reply-To: <614d0e03-6baf-861b-8636-71c07443b3b6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201705241202.43348.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 23 May 2017, J William Piggott wrote:
> On 05/23/2017 04:05 AM, Karel Zak wrote:
> > On Tue, May 23, 2017 at 09:57:33AM +0200, Karel Zak wrote:
> >> On Mon, May 22, 2017 at 05:37:28PM -0400, J William Piggott wrote:
> >>> My thoughts are that bugfix releases should be committed to
> >>> 'master' the same as the stable/rc releases are. Then the tag
> >>> created from that commit.
> >>
> >> How do you want to commit bugfix release (e.g. v2.29.2) to the
> >> 'master' if the master and 'stable/' branches contain a different
> >> code?
> >>
> >> The current workflow:
> >>
> >>  1) development (branch: <master>)
> >>
> >>  2) master release (tags: v2.29-rc1, v2.29-rc2, v2.29, branch:
> >> <master>)
> >>
> >>  3) development (work on v2.30, branch: <master>)
> >>
> >>  4) fork -- create a new branch <stable/v2.29> based on tag v2.29
> >>
> >>      4a) new patches or cherry-pick patches from <master> (branch:
> >> <stable/v2.29>)
> >>
> >>      4b) stable release (tag: v2.29.1, branch: <stable/v2.29>)
> >>
> >>      4c) another patches, another release (tag: v2.29.2, branch:
> >> <stable/v2.29>)
> >>
> >>  5) master release v2.30 (branch: <master>)
> >>     ...
> >>
> >>
> >> where 3) and 4) happen in the same time.
>
> Argh, my brain was broken. I wrongheadedly believed that this project
> was using linear development.
>
> > And yes, NEWS file in the master does not contain info about
> > maintenance release (e.g. v2.29.1). Maybe it's mistake.
>
> No, I was the mistake ;)
>
> > This information is in the ReleaseNotes where are links to the
> > previous maintenance releases.
> >
> > We can add a hint about maintenance releases to the master branch
> > NEWS file, but stable maintenance tags (v2.29.1) has to be in the
> > stable/ branches. It's released code what has to be tagged and
> > signed.
>
> It's all clear now that you've pulled my head out of ... its 'master'
> branch walled garden. The stable maintenance tags are not reachable
> from, pulled by, or have anything else to do with the 'master'
> branch. They belong only to their respective forked stable branches
> being developed independently. Hinting about them in master would
> probably be misleading.
>
> I think I will submit a patch to add something to Documentation about
> this so that someone else might not ask the same dumb questions. With
> your permission, I might include your well written workflow
> description.

FYI there is also "man 7 gitworkflows", worth to read IMO.

Beside the trivial fact that they use "maint" instead of "stable" they 
always provide one non-versioned "stable" branch which contains *all* 
tags, more easy to be followed by users. To be able to do that they 
*commit* bugfixes only to "stable" and *merge* them into master 
(instead of cherry-picking from master).

cu,
Rudi

> Sorry for wasting your time Karel (and anyone else reading this).
> Thank you for setting me straight.
>
> >     Karel
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


