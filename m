Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f170.google.com ([209.85.223.170]:47384 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbdJ3VlO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Oct 2017 17:41:14 -0400
Received: by mail-io0-f170.google.com with SMTP id h70so30545542ioi.4
        for <util-linux@vger.kernel.org>; Mon, 30 Oct 2017 14:41:14 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
        by smtp.googlemail.com with ESMTPSA id p198sm110361itp.3.2017.10.30.14.41.13
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 14:41:13 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
Message-ID: <1509399672.6057.30.camel@gmail.com>
Subject: History of Lazy and Force unmouting
To: util-linux@vger.kernel.org
Date: Mon, 30 Oct 2017 16:41:12 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

All,

I was hoping to get some background on why the util-linux umount
command doesn't allow lazy unmounting (the -l flag) to be combined with
force unmounting (the -f flag). If both flags are specified, umount
only passes MNT_DETACH to the kernel instead of MNT_DETACH | MNT_FORCE.
 I looked through the kernel code, and it appears that the two flags
are orthogonal, so you *should* be able to specify both? I tried
looking back in the git history of util-linux, but it appears to have
been that way since support for lazy unmounting was added in 2006.

Thanks,
Joshua Watt
