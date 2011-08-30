Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884Ab1H3KMq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Aug 2011 06:12:46 -0400
Date: Tue, 30 Aug 2011 12:12:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [patch 0/8] various lscpu patches
Message-ID: <20110830101242.GS1855@nb.net.home>
References: <20110810083645.135814950@de.ibm.com> <20110815084530.GA2400@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110815084530.GA2400@osiris.boeblingen.de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 10:45:30AM +0200, Heiko Carstens wrote:
> FWIW, I set up a git branch with the lscpu changes:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/heiko/util-linux.git lscpu

 Merged, thanks.

 Heiko, it would be nice to have a regression tests for various s390
 boxes. See tests/ts/lscpu/, there is mk-input.sh which is able to
 gather all necessary files and create a tarball from /sys and /proc.
 For s390 it will be probably necessary to extend the list of the files
 (e.g add /proc/sysinfo).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
