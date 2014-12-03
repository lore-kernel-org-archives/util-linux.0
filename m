Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbaLCQKl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Dec 2014 11:10:41 -0500
Date: Wed, 3 Dec 2014 17:10:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Francis Moreau <francis.moro@gmail.com>,
        "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org,
        gabeblack@chromium.org, gwendal@chromium.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't
 create partition devices
Message-ID: <20141203161029.GF1994@x2.net.home>
References: <201410031429.s93ET4wu014728@hobgoblin.ariadne.com>
 <201410031958.s93JwTuY026155@hobgoblin.ariadne.com>
 <542F065C.2080505@gmail.com>
 <54304C03.6020309@gmail.com>
 <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com>
 <5432BBB0.30701@gmail.com>
 <20141027201625.GA25833@vapier>
 <547E1337.1080702@ubuntu.com>
 <20141203083617.GD1994@x2.net.home>
 <547F22F7.30008@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547F22F7.30008@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 03, 2014 at 09:49:27AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/3/2014 3:36 AM, Karel Zak wrote:
> > Yes, I don't like the idea with the ioctl workaround in losetup.
> > It's fine to use such workarounds in stable branches or in distro
> > specific patches, but I really don't want to use workarounds for
> > bugs in regular releases (master branch).
> 
> Then again, maybe the whole idea of the kernel handling the partition
> table should be abandoned ( and the feature removed from the kernel )
> and losetup should just call partx and be done with it.

That's another story :-) And yes, I mostly agree.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
