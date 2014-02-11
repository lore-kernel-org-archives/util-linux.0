Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbaBKJWZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Feb 2014 04:22:25 -0500
Date: Tue, 11 Feb 2014 10:22:19 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: "Dale R. Worley" <worley@alum.mit.edu>, "Theodore Ts'o" <tytso@mit.edu>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Typo in mkfs man-page
Message-ID: <20140211092219.GT8506@x2.net.home>
References: <CAFeW3TRKCNKtXv-9mQC86JM6xQNySQn=csJQFa2RqBRBnbujug@mail.gmail.com>
 <20140210173545.GK8506@x2.net.home>
 <20140210185741.GF4724@thunk.org>
 <201402102055.s1AKt0q7015336@hobgoblin.ariadne.com>
 <CAG27Bk09kBXQ3B1Vtm6oDxw2iyqvsYbj9uYyGTdBgfLnLAvtsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk09kBXQ3B1Vtm6oDxw2iyqvsYbj9uYyGTdBgfLnLAvtsg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 11, 2014 at 09:05:32AM +0000, Sami Kerola wrote:
> On 10 February 2014 20:55, Dale R. Worley <worley@alum.mit.edu> wrote:
> >> From: "Theodore Ts'o" <tytso@mit.edu>
> >
> >> But /sbin/mkfs.xxx is generally run by system administrators, and IMHO
> >> it's better to tell people to run the command "/sbin/mkfs.xxx" instead
> >> of "/sbin/mkfs -t xxx".
> >
> > This makes sense to me.
> >
> > More exactly, mkfs is generally run "manually".
> >
> > And while having fsck "do what I mean" is largely safe, creating a
> > file system is not the time that you want the user to be unclear on
> > the exact implications of each option he has specified.
> 
> Would it make sense to add banner 'you probably should not run this
> utility, consider using file system specific mkfs' to mkfs?

And mark it deprecated and one day kill it at all.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
