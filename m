Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab3KHJJK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Nov 2013 04:09:10 -0500
Date: Fri, 8 Nov 2013 10:09:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Generating release from git
Message-ID: <20131108090906.GB10401@x2.net.home>
References: <527C3112.40904@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <527C3112.40904@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 07, 2013 at 07:32:18PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> How do you generate the release tarball from the git repo?  I thought
> it would be to run make dist, but it seems the real release tarball is
> bootstrapped with autogen.sh, but NOT configured, and make dist
> generates a tarball that is already configured.

if you have autotools based build system than

   make distcheck

is only way how to generate reliable and consistent tarballs.
My release sequence is usually:

 git tag -s -m "release ${UL_NEXT_RELEASE}" ${UL_NEXT_RELEASE}
 git clean -xfd
 ./autogen.sh
 ./tools/config-gen devel    # or ./configure
 make -j
 make distcheck

note that build system uses tools/git-version-gen to get release
version so "git tag" is necessary to get proper release number.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
