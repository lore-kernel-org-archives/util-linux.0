Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33636 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbcJDHlh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Oct 2016 03:41:37 -0400
Received: by mail-pf0-f173.google.com with SMTP id 190so26088927pfv.0
        for <util-linux@vger.kernel.org>; Tue, 04 Oct 2016 00:41:37 -0700 (PDT)
Received: from kmo-pixel (213-168-42-72.gci.net. [72.42.168.213])
        by smtp.gmail.com with ESMTPSA id h65sm52377961pfg.18.2016.10.04.00.41.34
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Oct 2016 00:41:35 -0700 (PDT)
Date: Mon, 3 Oct 2016 23:41:32 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: util-linux@vger.kernel.org
Subject: Bug with read only handling in mount
Message-ID: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/mount.c, mk_exit_code()

If the mount syscall returns EACCESS, the code treats this as meaning that RW
access to the block device wasn't allowed - it switches to RO for all future
mount attempts.

This is incorrect though, because EACCESS could just mean that that particular
filesystem doesn't support RW: iso9600 returns EACCESS if you try to mount RW.

The end result is that if we're trying to mount by trying every filesystem type
(your libblkid doesn't know about your filesystem yet..), and the correct
filesystem was listed after iso9600 in /proc/filesystems, mount will always
mount RO (unless you specify the filesystem type with -t).
