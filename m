Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab2G3PVB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jul 2012 11:21:01 -0400
Date: Mon, 30 Jul 2012 17:20:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] tests: use ts_is_mounted in mount/regfile
Message-ID: <20120730152056.GG5845@x2.net.home>
References: <50125A02.9030004@bernhard-voelker.de>
 <50125C24.6090708@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50125C24.6090708@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 11:15:16AM +0200, Bernhard Voelker wrote:
> >   $ /home/berny/ul/umount /home/berny/ul/tests/output/mount/regfile.img
> >   umount: /home/berny/ul/tests/output/mount/regfile.img: not mounted
> 
> hmm, also other tests like mount/remount are failing.
> 
> Somehow, I have the impression that TS_MOUNTPOINT should be canonicalized

 Good point.

 I have added ts_canonicalize() and improved ts_init() to use it for
 all basic paths. It's probably more robust to use realpaths everywhere.

> in function.sh in ts_init_core_env and ts_init_core_subtest_env, but on the
> other side, this would eclipse errors like the above. WDYT?

 Well, important is to detect if the filesystem is mounted. We have
 special tests for mounting by symlinks where ts_canonicalize() is not
 called for the mountpoint.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
