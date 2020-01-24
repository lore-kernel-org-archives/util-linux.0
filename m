Return-Path: <SRS0=7xEu=3N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD93C2D0DB
	for <util-linux@archiver.kernel.org>; Fri, 24 Jan 2020 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9974720709
	for <util-linux@archiver.kernel.org>; Fri, 24 Jan 2020 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNPgVKiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAXPxu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:53:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbgAXPxu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jan 2020 10:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579881229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0ihvg6/8J0yB5dGMbm8QQOnnlGHafa6tG6Y9MDBJXnM=;
        b=JNPgVKiR+Z1/iosI5BlmoosI+YYG18oYcKqCIlDYBeZFerpCbUHPSSVtn8C/yLFHMRRQWQ
        gesCk/QELZH21Dqh6SQVGGNotKaAfIpIspwOmwg2VLOeutpSW8SxZ7ASDtsU0/nXOTiiVz
        GqqZRsK3uwwa4ynL7WBrnslpdaHrlr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-y7cVVPsBM9y2a8GheaL2jg-1; Fri, 24 Jan 2020 10:53:46 -0500
X-MC-Unique: y7cVVPsBM9y2a8GheaL2jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2624D195A76F;
        Fri, 24 Jan 2020 15:53:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-39.ams2.redhat.com [10.36.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9F95DA2C;
        Fri, 24 Jan 2020 15:53:37 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        powerpc-utils-devel@googlegroups.com, util-linux@vger.kernel.org,
        Badari Pulavarty <pbadari@us.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Karel Zak <kzak@redhat.com>
Subject: [PATCH RFC] drivers/base/memory.c: indicate all memory blocks as removable
Date:   Fri, 24 Jan 2020 16:53:36 +0100
Message-Id: <20200124155336.17126-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

We see multiple issues with the implementation/interface to compute
whether a memory block can be offlined (exposed via
/sys/devices/system/memory/memoryX/removable) and would like to simplify
it (remove the implementation).

1. It runs basically lockless. While this might be good for performance,
   we see possible races with memory offlining/unplug that will require
   at least some sort of locking to fix.

2. Nowadays, more false positives are possible. No arch-specific checks
   are performed that validate if memory offlining will not be denied
   right away (and such check will require locking). For example, arm64
   won't allow to offline any memory block that was added during boot -
   which will imply a very high error rate. Other archs have other
   constraints.

3. The interface is inherently racy. E.g., if a memory block is
   detected to be removable (and was not a false positive at that time),
   there is still no guarantee that offlining will actually succeed. So
   any caller already has to deal with false positives.

4. It is unclear which performance benefit this interface actually
   provides. The introducing commit 5c755e9fd813 ("memory-hotplug: add
   sysfs removable attribute for hotplug memory remove") mentioned
	"A user-level agent must be able to identify which sections of
	 memory are likely to be removable before attempting the
	 potentially expensive operation."
   However, no actual performance comparison was included.

Known users:
- lsmem: Will group memory blocks based on the "removable" property. [1]
- chmem: Indirect user. It has a RANGE mode where one can specify
	 removable ranges identified via lsmem to be offlined. However, it
	 also has a "SIZE" mode, which allows a sysadmin to skip the manual
	 "identify removable blocks" step. [2]
- powerpc-utils: Uses the "removable" attribute to skip some memory
		 blocks right away when trying to find some to
		 offline+remove. However, with ballooning enabled, it
		 already skips this information completely (because it
		 once resulted in many false negatives). Therefore, the
		 implementation can deal with false positives properly
		 already. [3]

With CONFIG_MEMORY_HOTREMOVE, always indicating "removable" should not
break any user space tool. We implement a very bad heuristic now. (in
contrast: always returning "not removable" would at least affect
powerpc-utils)

Without CONFIG_MEMORY_HOTREMOVE we cannot offline anything, so report
"not removable" as before.

Original discussion can be found in [4] ("[PATCH RFC v1] mm:
is_mem_section_removable() overhaul").

Other users of is_mem_section_removable() will be removed next, so that
we can remove is_mem_section_removable() completely.

[1] http://man7.org/linux/man-pages/man1/lsmem.1.html
[2] http://man7.org/linux/man-pages/man8/chmem.8.html
[3] https://github.com/ibm-power-utilities/powerpc-utils
[4] https://lkml.kernel.org/r/20200117105759.27905-1-david@redhat.com

Suggested-by: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: powerpc-utils-devel@googlegroups.com
Cc: util-linux@vger.kernel.org
Cc: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Karel Zak <kzak@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

1. Are there any use cases that really require this interface to keep
   producing "more reliable" results?

2. Is there any real performance advantage when using this interface to
   identify memory blocks to offline?

---
 drivers/base/memory.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6503f5d0b749..d78a92f09984 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -105,30 +105,17 @@ static ssize_t phys_index_show(struct device *dev,
 }
=20
 /*
- * Show whether the memory block is likely to be offlineable (or is alre=
ady
- * offline). Once offline, the memory block could be removed. The return
- * value does, however, not indicate that there is a way to remove the
- * memory block.
+ * Legacy interface that we cannot remove. Always indicate "removable"
+ * with CONFIG_MEMORY_HOTREMOVE - bad heuristic.
  */
 static ssize_t removable_show(struct device *dev, struct device_attribut=
e *attr,
 			      char *buf)
 {
-	struct memory_block *mem =3D to_memory_block(dev);
-	unsigned long pfn;
-	int ret =3D 1, i;
-
-	if (mem->state !=3D MEM_ONLINE)
-		goto out;
-
-	for (i =3D 0; i < sections_per_block; i++) {
-		if (!present_section_nr(mem->start_section_nr + i))
-			continue;
-		pfn =3D section_nr_to_pfn(mem->start_section_nr + i);
-		ret &=3D is_mem_section_removable(pfn, PAGES_PER_SECTION);
-	}
-
-out:
-	return sprintf(buf, "%d\n", ret);
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	return sprintf(buf, "1\n");
+#else
+	return sprintf(buf, "0\n");
+#endif
 }
=20
 /*
--=20
2.24.1

