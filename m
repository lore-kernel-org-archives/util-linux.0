Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ABBC4332F
	for <util-linux@archiver.kernel.org>; Wed, 16 Nov 2022 02:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKPCAx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKPCAw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 15 Nov 2022 21:00:52 -0500
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA12A97C
        for <util-linux@vger.kernel.org>; Tue, 15 Nov 2022 18:00:48 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 346171003D2
        for <util-linux@vger.kernel.org>; Wed, 16 Nov 2022 13:00:42 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4K3sK4wNokfD for <util-linux@vger.kernel.org>;
        Wed, 16 Nov 2022 13:00:42 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 2825E10030D; Wed, 16 Nov 2022 13:00:42 +1100 (AEDT)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 3108D10030D;
        Wed, 16 Nov 2022 13:00:40 +1100 (AEDT)
Subject: [PATCH 0/2] Add ability to use autofs mount option hint to exclude
 mount table list entries
From:   Ian Kent <raven@themaw.net>
To:     util-linux <util-linux@vger.kernel.org>
Cc:     Karel Zak <kzak@redhat.com>, John Westerdale <jwesterd@redhat.com>,
        fhirtz@redhat.com
Date:   Wed, 16 Nov 2022 10:00:39 +0800
Message-ID: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Historically autofs mounts were not included in mount table listings.

This is the case in other SysV autofs implementations and was also
the case with Linux autofs until we changed to use the proc file system
for the mount table.

This often leads to considerable clutter for system administrators so
it's necessary to find a way to exclude these entries from mount table
listings without causing problems for sub-systems that may need the
entries to be present.

In other Unix autofs implementations we see this is done by including
a pseudo mount option that's used as a hint by applications that want
to exclude these entries.

There's further discussion of this in the first patch.

I started trying to do this quite a while ago, glibc, automount(8) and
the kernel have been updated to use such a mount option but, for some
reason, when I canme to update util-linux I thought it would cause
problems for systemd. But when I looked at what I had done just recently
I saw that isn't the case so I'm now continuing with this change.

What I've done might not be the prefered way to do this so any comments
are welcome so it can be done the way it fits best with util-linux.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (2):
      libmount: use autofs mount hint to ignore autofs mount entries
      mount: ignore autofs entries in mount listing


 libmount/src/context.c     | 19 +++++++++++++++++++
 libmount/src/libmount.h.in |  2 ++
 libmount/src/libmount.sym  |  3 +++
 libmount/src/mountP.h      |  7 ++++++-
 libmount/src/tab_parse.c   | 33 +++++++++++++++++++++++++++++++++
 sys-utils/mount.c          |  2 ++
 6 files changed, 65 insertions(+), 1 deletion(-)

--
Ian

