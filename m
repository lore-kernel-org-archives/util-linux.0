Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:55934 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941788AbcKQKoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 17 Nov 2016 05:44:24 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH 4/5] build-sys: remove old git fallback from git-version-gen
Date: Thu, 17 Nov 2016 11:44:19 +0100
Cc: util-linux@vger.kernel.org
References: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de> <1479348602-31744-4-git-send-email-sweet_f_a@gmx.de> <43681c47-6153-3100-7582-c41e7ea89d7e@bernhard-voelker.de>
In-Reply-To: <43681c47-6153-3100-7582-c41e7ea89d7e@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201611171144.19782.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 November 2016, Bernhard Voelker wrote:
> On 11/17/2016 03:10 AM, Ruediger Meier wrote:
> > Just make the script more readable. Nobody is using 10 years old
> > git.
> >
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  tools/git-version-gen | 21 ---------------------
> >  1 file changed, 21 deletions(-)
>
> Is there any particular reason not to sync from latest
> upstream (again)?
>
> http://g.sv.gnu.org/cgit/gnulib.git/tree/build-aux/git-version-gen

I only want to fix some cosmetical issues regarding our version numbers. 
Don't want to risk making things worse. This particulary removed 
fallback was probably never used in UL and probably broken since we've 
added our special "-rc* handling.

Regarding gnulib upstream, IMO their git-version-gen is overengineered 
and too complicated. We don't need any of the new 
options --prefix, --fallback, --help or --version.

BTW the real upstream would be
https://github.com/git/git/blob/master/GIT-VERSION-GEN
which is simple to understand and easy to add small project-specific 
changes.


cu,
Rudi
