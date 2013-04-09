Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935753Ab3DIMjJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Apr 2013 08:39:09 -0400
Date: Tue, 9 Apr 2013 14:39:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Jeff Mahoney <jeffm@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] loopdev: sync capacity after setting it
Message-ID: <20130409123902.GA26442@x2.net.home>
References: <51438CF9.7020707@suse.com>
 <5145D0B4.1070207@suse.com>
 <20130318092700.GC2172@x2.net.home>
 <51471122.6030804@suse.com>
 <20130318131827.GE2172@x2.net.home>
 <51535A4C.4060604@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51535A4C.4060604@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 04:45:00PM -0400, Jeff Mahoney wrote:
>  include/loopdev.h        |    1 
>  lib/Makefile.am          |    4 +-
>  lib/blkdev.c             |    2 -
>  lib/loopdev.c            |   89 +++++++++++++++++++++++++++++++++++++++++++++--
>  libmount/src/Makefile.am |    1 
>  mount/mount.8            |   16 ++++++++
>  sys-utils/Makefile.am    |    3 +
>  sys-utils/losetup.c      |   19 ++--------
>  8 files changed, 114 insertions(+), 21 deletions(-)

It seems you have some very old version (or stable/ branch? :-) I have
ported the patch to the current git master and merged.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
