Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58383 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbaFBKd2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jun 2014 06:33:28 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: build-sys: minor issues
Date: Mon, 2 Jun 2014 12:33:23 +0200
Cc: util-linux@vger.kernel.org
References: <201406020056.17074.sweet_f_a@gmx.de> <20140602094243.GM9000@x2.net.home>
In-Reply-To: <20140602094243.GM9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406021233.23463.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Karel Zak wrote:
> On Mon, Jun 02, 2014 at 12:56:16AM +0200, Ruediger Meier wrote:
> > 1. ./configure --enable-all-programs
> > also triggers --enable-deprecated-last. Would be nice to exclude
> > this deprecated stuff somehow.
>
>  fixed, thanks for your report.

Thanks! All the recent build-sys tweaks were really helpful!

> > 2. make dist
> > changes files in source dir, which makes the git clone dirty. Would
> > be nice if we could avoid this somehow.
>
>  What files? I see po/ stuff modification and it's more political
>  issue than technical. The reason is that I update po/ only once
>  before release (to avoid many many huge commits with irrelevant
>  changes).

I have to admit that I'm not really familar with this translations.
But IMO generally it's not nice that "make dist" pollutes the git
clone.

I see 3 possibilities how to avoid this.

1. Don't track these po files in git at all. Always generate in
   builddir. Put them into dist only.
2. Don't update them with "make dist". Add new target "make update-po".
3. Keep them in srcdir but update to builddir. Add a script
   "commit-po-updates" to manulally move them from builddir to
   srcdir from time to time. 

My use case is a cronjob like this
  git pull origin
  ./autogen.sh && ./configure && make dist
  "push-tarball-to-build-host" 

Because of the current git pollution I have to do always "git 
reset --hard" before "autogen.sh" to not have "-dirty" suffixed version 
numbers.

cu,
Rudi 
