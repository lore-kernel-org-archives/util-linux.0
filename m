Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28613 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab3KHO4s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Nov 2013 09:56:48 -0500
Date: Fri, 8 Nov 2013 15:56:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Generating release from git
Message-ID: <20131108145645.GB12667@x2.net.home>
References: <527C3112.40904@ubuntu.com>
 <20131108090906.GB10401@x2.net.home>
 <527CF712.90809@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <527CF712.90809@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 08, 2013 at 09:37:06AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/8/2013 4:09 AM, Karel Zak wrote:
> > On Thu, Nov 07, 2013 at 07:32:18PM -0500, Phillip Susi wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA512
> >> 
> >> How do you generate the release tarball from the git repo?  I
> >> thought it would be to run make dist, but it seems the real
> >> release tarball is bootstrapped with autogen.sh, but NOT
> >> configured, and make dist generates a tarball that is already
> >> configured.

 I see that after "make dist" the tarball is not configured (for
 example there is no config.h).

> > if you have autotools based build system than
> > 
> > make distcheck
> 
> Doesn't this do the same thing as make dist, only with a make check
> and such thrown in?

 Yes, it seems the same, but it does not call "make check" only
 but it also checks if the tarball is usable (it calls make,
 make install, etc.).

> So if you don't want to do the tests and just
> generate the original tarball, make dist would do the trick right?

 yes

> Yet it seems to leave files in the tarball that are NOT in the
> official release.

 Yes, for example .gitignore files etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
