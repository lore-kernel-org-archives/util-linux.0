Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:58446 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2G0JPT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 05:15:19 -0400
Message-ID: <50125C24.6090708@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 11:15:16 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] tests: use ts_is_mounted in mount/regfile
References: <50125A02.9030004@bernhard-voelker.de>
In-Reply-To: <50125A02.9030004@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/27/2012 11:06 AM, Bernhard Voelker wrote:
> The following patch fixes a test framework failure.
> 
> However, even with this patch applied, mount/regfile still fails
> because umount fails:
> 
>   $ /home/berny/ul/umount /home/berny/ul/tests/output/mount/regfile.img
>   umount: /home/berny/ul/tests/output/mount/regfile.img: not mounted

hmm, also other tests like mount/remount are failing.

Somehow, I have the impression that TS_MOUNTPOINT should be canonicalized
in function.sh in ts_init_core_env and ts_init_core_subtest_env, but on the
other side, this would eclipse errors like the above. WDYT?

Have a nice day,
Berny
