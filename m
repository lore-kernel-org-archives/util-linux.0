Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F20C433FE
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0C261BE1
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhKQCNq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKQCNq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Nov 2021 21:13:46 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E4C061570
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:48 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id m25so1149314qtq.13
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+Ch5r24dMMZvzXrgQXZgAv25/ZB4nFiHZ5XgO4di7M=;
        b=ibnOqTpMfw4EqH136U7qpQDX+C2BEgHjyseQkUSFiugiE1+EVFmb9BCzo3KSz6dFLM
         EO+u9PcJnOoU5XSwFHGRhbmCuAXjk/ZfXI0kNmPmcvWQgIgOj7EBdB5PP3KAElVmvjCC
         jvRoCiF8l1Vwf5/TjB+V9Rym2xO+0qGGrKIgzSQsqFdDx6tFuRlrMnUNzSmRKjLzl0R6
         a0KI2RiYrmgLd93W+waixjcbvU7H7F9Ae2ixv/6vUtVI5VCUtZlQU0qrT/e+h4MD5j71
         d/a7CI05StqTiRWzfdGjNDeBURqJuwbXEjnL7qml3wnEJrslJYSxaZOc1OOY7YEmoZ+J
         5Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+Ch5r24dMMZvzXrgQXZgAv25/ZB4nFiHZ5XgO4di7M=;
        b=sWpWgBjd5XV7OeB3llp8xc9tcbaNqURK7+MTiW69uT+BDYdRm/6qnxBrqQwes9ZjQt
         jIOfmKA7MzXJ5KVPijduQfEIMSCnFR9gcIqRNmfdRUibkhutIryu6igPZ3qWRL5qqzup
         2TiuJLvtzKP95/M8bDCuedlHTVZwuviOLYdnQh8g/Cd4tE29tamdM5Kj6ZmpXrYVD2yj
         pODUqK1XU+E3cEsFa221QcvC5ef2ZOEQ6zbccPBut8fixIgJs86iPhnzK95sS440hktb
         8iMU4hdJEawUmMIIAd1TCEAZ6amFGVT18gnRs5/8KQHpBTaBj6K8niLb4LBbhL6+ecsF
         aUzg==
X-Gm-Message-State: AOAM533CWz1MTMMY5+xkvpr+D65KxYEdaZ9YISo7BShHtZCEKpnr1xP6
        Je/jHsMe47rTe/8Uzxzsj83h5AzmZ7o=
X-Google-Smtp-Source: ABdhPJzFnc6NwA4eK1XKQb0jIUJ1RBYwtfokphbMzJ3210tVirTSJuLSvQkpBqV1toLhN3E0Baz53A==
X-Received: by 2002:ac8:5946:: with SMTP id 6mr13024470qtz.373.1637115047800;
        Tue, 16 Nov 2021 18:10:47 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id t11sm9326200qkm.96.2021.11.16.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:10:47 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 5/5] unshare: Document --map-{groups,users,auto}
Date:   Tue, 16 Nov 2021 21:10:38 -0500
Message-Id: <20211117021038.823851-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117021038.823851-1-seanga2@gmail.com>
References: <20211117021038.823851-1-seanga2@gmail.com>
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

 sys-utils/unshare.1.adoc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 74183ebc1..531d42be1 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -93,9 +93,18 @@ Just before running the program, mount the proc filesystem at _mountpoint_ (defa
 **--map-user=**__uid|name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
+**--map-users=**__outeruid,inneruid,count__::
+Run the program only after the block of user IDs of size _count_ beginning at _outeruid_ has been mapped to the block of user IDs beginning at _inneruid_. This mapping is created with *newuidmap*(1). If the range of user IDs overlaps with the mapping specified by *--map-user*, then a "hole" will be removed from the mapping. This may result in the highest user ID of the mapping not being mapped. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
+
 **--map-group=**__gid|name__::
 Run the program only after the current effective group ID has been mapped to _gid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--setgroups=deny* and *--user*.
 
+**--map-groups=**__outergid,innergid,count__::
+Run the program only after the block of group IDs of size _count_ beginning at _outergid_ has been mapped to the block of group IDs beginning at _innergid_. This mapping is created with *newgidmap*(1). If the range of group IDs overlaps with the mapping specified by *--map-group*, then a "hole" will be removed from the mapping. This may result in the highest group ID of the mapping not being mapped. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--group*.
+
+**--map-auto**::
+Map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. In the same manner, also map the first block of group IDs owned by the effective group from _/etc/subgid_ to a block starting at group ID 0. This option is intended to handle the general case where all available subordinate user and group IDs are used to map as much of the ID space as possible. This option is equivalent to specifying **--map-users** and **--map-groups** with appropriate arguments.
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

