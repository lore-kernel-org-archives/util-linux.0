Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C5C433EF
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 18:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbhKXS3q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhKXS3q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Nov 2021 13:29:46 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493FBC061574
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:36 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j17so3626122qtx.2
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xz59MSro5woO1NPFQXBKTnK98BJos3uGXt0V8322EwE=;
        b=iwOR7fgjzoOa3/tfBexxaGeChuq+7yDbVHTduwFtee9k2+1WtGvPSnSXYizBOJN8Aq
         9Iv2TopC/oVQ0M8CK9W5GJeVFfJf188zXbGFbPe4DjcgXvpzcXPxszoAVHTr1/1aeEav
         lJZauMAiO7aysQj3RJ/1yBtLUU0D3d+A0dORXluzRiWoNBvuYnkNUfdG6u3ocxnwhcaX
         hNRuXM3UyulX6WRMX/lOFlrFTkO6DzMntSVBFf6pjsjYDKyfi6gump/4R/ygELlfd7K5
         Hmlz7eZpiDvMvg+9+xXb5dxMMi3ExageC+pMjiL9mBMuofcI/kQtoftUrqiSdwMl7xGE
         cQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xz59MSro5woO1NPFQXBKTnK98BJos3uGXt0V8322EwE=;
        b=Ik18KI/LOZ1EqOc8gNqohDzHZOR2MH58wC0FIDHAx9FMizNSOouB6EpWGcWiNzpxdL
         +McoRwGUbz5KzG4R5JhCR6ojPZFbBX67npDeXDLYqbzdGr6zmZXCvsNaueogjNt0w/dR
         UMProItJYUL91hDL8EQGjxMf4Q+k4xWo3rt8XyE/geoQRm3ZvvznBtHQ7ad9ZXXZEdcw
         IrQdoDG1JblDMuc8RBTYbfu0nsBiJZrHiZwTdTuIBiMOwpuzUL9NOeQlmguKKAXfZDd9
         m2ugk2ZBr5hrnmFomxz8WzNZdjVaXEPmws9c8uXJ5jArA8DPg6t6Yrl3Zq7E86YrWoH4
         nhwg==
X-Gm-Message-State: AOAM531jtskEXv5P7FlHiFwOjZnvOqNGjx57t2A221Jj4+2+BAILNN68
        ZutZ+3Wpkj8Q01O5oq5rOWpYWLmoAHE=
X-Google-Smtp-Source: ABdhPJykbtRxxMlOgo3mXoHDNdO2lpw3bcJ9NSyv730cwpDG626MSPlhzH5zXfcYFUUwMwVvkLhyCw==
X-Received: by 2002:ac8:4e51:: with SMTP id e17mr9782931qtw.129.1637778395164;
        Wed, 24 Nov 2021 10:26:35 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id h19sm274936qth.63.2021.11.24.10.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:26:34 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 6/6] unshare: Document --map-{groups,users,auto}
Date:   Wed, 24 Nov 2021 13:26:18 -0500
Message-Id: <20211124182618.1801447-7-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124182618.1801447-1-seanga2@gmail.com>
References: <20211124182618.1801447-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This documents the new options added in the previous few commits.
I have added another example to better demonstrate the these
options. The actual use is fairly straightforward, but the descriptions
are on the pithier side.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Document new "auto" value for --map-user and --map-group
- Fix typo of --group instead of --user

 sys-utils/unshare.1.adoc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 74183ebc1..cb1302461 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -93,9 +93,18 @@ Just before running the program, mount the proc filesystem at _mountpoint_ (defa
 **--map-user=**__uid|name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
+**--map-users=**__outeruid,inneruid,count__|**auto**::
+Run the program only after the block of user IDs of size _count_ beginning at _outeruid_ has been mapped to the block of user IDs beginning at _inneruid_. This mapping is created with **newuidmap**(1). If the range of user IDs overlaps with the mapping specified by *--map-user*, then a "hole" will be removed from the mapping. This may result in the highest user ID of the mapping not being mapped. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
+
 **--map-group=**__gid|name__::
 Run the program only after the current effective group ID has been mapped to _gid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--setgroups=deny* and *--user*.
 
+**--map-groups=**__outergid,innergid,count__|**auto**::
+Run the program only after the block of group IDs of size _count_ beginning at _outergid_ has been mapped to the block of group IDs beginning at _innergid_. This mapping is created with **newgidmap**(1). If the range of group IDs overlaps with the mapping specified by *--map-group*, then a "hole" will be removed from the mapping. This may result in the highest group ID of the mapping not being mapped. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subgid_ to a block starting at group ID 0. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
+
+**--map-auto**::
+Map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. In the same manner, also map the first block of group IDs owned by the effective group from _/etc/subgid_ to a block starting at group ID 0. This option is intended to handle the common case where the first block of subordinate user and group IDs can map the whole user and group ID space. This option is equivalent to specifying *--map-users=auto* and *--map-groups=auto*.
+
 *-r*, *--map-root-user*::
 Run the program only after the current effective user and group IDs have been mapped to the superuser UID and GID in the newly created user namespace. This makes it possible to conveniently gain capabilities needed to manage various aspects of the newly created namespaces (such as configuring interfaces in the network namespace or mounting filesystems in the mount namespace) even when run unprivileged. As a mere convenience feature, it does not support more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs. This option implies *--setgroups=deny* and *--user*. This option is equivalent to *--map-user=0 --map-group=0*.
 
@@ -160,6 +169,27 @@ root
          0       1000          1
 ....
 
+As an unprivileged user, create a user namespace where the first 65536 IDs are all mapped, and the user's credentials are mapped to the root IDs inside the namespace. The map is determined by the subordinate IDs assigned in *subuid*(5) and *subgid*(5). Demonstrate this mapping by creating a file with user ID 1 and group ID 1. For brevity, only the user ID mappings are shown:
+
+....
+$ id -u
+1000
+$ cat /etc/subuid
+1000:100000:65536
+$ unshare --user --map-auto --map-root-user
+# id -u
+0
+# cat /proc/self/uid_map
+         0       1000          1
+         1     100000      65535
+# touch file; chown 1:1 file
+# ls -ln --time-style=+ file
+-rw-r--r-- 1 1 1 0  file
+# exit
+$ ls -ln --time-style=+ file
+-rw-r--r-- 1 100000 100000 0  file
+....
+
 The first of the following commands creates a new persistent UTS namespace and modifies the hostname as seen in that namespace. The namespace is then entered with *nsenter*(1) in order to display the modified hostname; this step demonstrates that the UTS namespace continues to exist even though the namespace had no member processes after the *unshare* command terminated. The namespace is then destroyed by removing the bind mount.
 
 ....
@@ -235,6 +265,8 @@ mailto:kzak@redhat.com[Karel Zak]
 
 == SEE ALSO
 
+*newuidmap*(1)
+*newgidmap*(1)
 *clone*(2),
 *unshare*(2),
 *namespaces*(7),
-- 
2.33.0

