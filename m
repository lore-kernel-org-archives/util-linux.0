Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10D9C433EF
	for <util-linux@archiver.kernel.org>; Fri, 14 Jan 2022 10:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiANKgs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Jan 2022 05:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiANKgr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2022 05:36:47 -0500
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jan 2022 02:36:46 PST
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F6C061574
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2022 02:36:46 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JZyF25BmlzMrjXM;
        Fri, 14 Jan 2022 11:28:22 +0100 (CET)
Received: from jura (unknown [84.73.10.131])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4JZyF21QBNzlhSMb;
        Fri, 14 Jan 2022 11:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atufi.org;
        s=20191114; t=1642156102;
        bh=BwInjmiFrwU1a2h6EtjhhC5IicwoPfXLcLK50Je2HYk=;
        h=From:To:Cc:Subject:In-reply-to:Date:From;
        b=ZHM8WUacF+p9GSuNvmMrdglUtXmX6/4GktFvXV9mF3kzGZ7KRlBfXOXlUWfCG1vmH
         mF/9M5BivfwU3tbNoFIdO38zB4gWk0amElwc8yl/SHP+hbVErOB61HfgsXiGWxmyDW
         p6xiRAVV+lCnOmZ2G4tfq3GS8dKh00Ec0m/YR89E=
From:   Daniel Gerber <dg@atufi.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     dottedmag@dottedmag.net, id@mbekkema.name, jpeach@apache.org,
        kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/6] unshare: Add support for mapping ranges of
 user/group IDs
In-reply-to: <20211124182618.1801447-1-seanga2@gmail.com>
Date:   Fri, 14 Jan 2022 11:29:21 +0100
Message-ID: <874k664nlq.fsf@atufi.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

Thanks for this feature. I've been trying it out... (This is with lib-musl-x86_64.)

Automatic mapping works:

$ unshare --map-users=auto cat /proc/self/uid_map
         0     100000      65536

But parsing id ranges does not:

$ unshare --map-users=100000,0,65536 cat /proc/self/uid_map
unshare: could not parse ID: '100000,0,65536'

Fix:
---
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 443358952..52bd9702a 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -388,7 +388,7 @@ static int uint_to_id(const char *name, size_t sz)
 	char buf[UID_BUFSIZ];

 	mem2strcpy(buf, name, sz, sizeof(buf));
-	return strtoul_or_err(name, _("could not parse ID"));
+	return strtoul_or_err(buf, _("could not parse ID"));
 }

 /**
---

Then, the value passed to newuidmap is still incorrect:

$ unshare --map-users=100000,0,65536 cat /proc/self/uid_map
newuidmap: uid range [0-655360) -> [100000-755360) not allowed

$ unshare --map-users=100000,0,0065536 cat /proc/self/uid_map
         0     100000      65536

The count value gets zero-padded to the right at some place I've not pinned down.


Also, I would suggest adopting the same argument order as in /proc/<pid>/uid_map and newuidmap -- inner,outer,count.

This doc string has it reversed:
---
/**
 * struct map_range - A range of IDs to map
 * @outer: First ID inside the namespace
 * @inner: First ID outside the namespace
---

And this one has inconsistent terminology:
---
 * get_map_range() - Parse a mapping range from a string
 * @s: A string of the format upper,lower,count
 *
 * Parse a string of the form upper,lower,count into a new mapping range.
---


--
Daniel Gerber
