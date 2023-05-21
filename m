Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE5C7EE23
	for <util-linux@archiver.kernel.org>; Sun, 21 May 2023 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEUQXb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 21 May 2023 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEUQXa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 21 May 2023 12:23:30 -0400
X-Greylist: delayed 296 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 May 2023 09:23:25 PDT
Received: from fifth.space (fifth.space [45.32.148.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E68D2
        for <util-linux@vger.kernel.org>; Sun, 21 May 2023 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fifth.space; s=20190812;
        t=1684685903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j3W0SqDom3ssfHcCJ6bodcpJ1f+Ij/Ta4ERT87kq0nQ=;
        b=ZWZuVEppMsGSP2h35HaYIuenqkFWPy+2w/TMBfhjvwK6KWBTWKzbX1aU+dGTFCxjC+/HyF
        u9o0onNlBqDFtLMG5ME94ahy6yppSZvi5RIItCe70Rbq7WXWLj7KHVSMNlhUh8a6HWWekL
        OIjwvDM0xJ8ZMg3PY2BmvNr+POzAqQAifyRU91n+kBzl2Bt/5FGEWxo3lUasWaiNfxhycl
        5pjAny9l1C4hmE2+55l19YbBx0DqC7qQxtifWqlfc1yI9jHnbwaR8sXnH3pFftjhEHtq5d
        vumoxJgSOsz4PuM0/AVukMQvcE5KSanIZoMfzgzRJ+fL0OE+UnyF7qbWLZwjYQ==
Received: by fifth.space (OpenSMTPD) with ESMTPSA id 8ad3d622 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <util-linux@vger.kernel.org>;
        Sun, 21 May 2023 18:18:18 +0200 (CEST)
Date:   Sun, 21 May 2023 18:18:14 +0200
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Subject: mount: sshfs problem with "defaults" option after 2.39 upgrade
Message-ID: <20230521181814.0b0f2d38.quinq@fifth.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

I just updated util-linux to 2.39 from 2.38.1 (on Alpine Linux),
and new mount triggers an error for an old sshfs fstab mount entry,
that was working until now.

The line in question is:

user@host:path /media/ssh/path sshfs defaults,nosuid,nodev,noexec,noatime,noauto,_netdev,user,idmap=user,allow_other,rec 0 0

and fails with:

$ mount /media/ssh/path
fuse: unknown option(s): `-o defaults'

I can see in the trace that "defaults" is actually passed to the helper

30906 execve("/sbin/mount.sshfs", ["/sbin/mount.sshfs", "user@host:path", "/media/ssh/path", "-o", "rw,defaults,noatime,_netdev,...", <truncated here>

And running it with LIBMOUNT_DEBUG=all shows

30933: libmount:   UPDATE: 30933: libmount:       FS: synced: vfs: 'rw,noatime,nodev,nosuid,noexec' fs: 'idmap=user,allow_other,reconnect' user: 'defaults,noauto,_netdev,, optstr: 'rw,defaults,noatime,noauto,_netdev,user=quinq,nodev,nosuid,noexec,allow_other,reconnect'
[...]
optstr: rw,defaults,noatime,noauto,_netdev,nodev,nosuid,noexec,idmap=user,allow_other,reconnect
VFS-optstr: rw,noatime,nodev,nosuid,noexec
FS-opstr: idmap=user,allow_other,reconnect
user-optstr: defaults,noauto,_netdev

The "defaults" option is stripped from the analog traces with mount 2.38.1
