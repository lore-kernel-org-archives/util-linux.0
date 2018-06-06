Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33071 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeFFOur (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 Jun 2018 10:50:47 -0400
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5DEC0AC38
        for <util-linux@vger.kernel.org>; Wed,  6 Jun 2018 14:50:46 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Dominik Heidler <dheidler@suse.de>
Subject: Bug: "blkid -o list" output formating is broken
Message-ID: <9d6d94f3-cb99-45e6-4170-2bb744f5878b@suse.de>
Date: Wed, 6 Jun 2018 16:50:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

when I run "blkid -o list" on a terminal with width >= 178 chars
the output will be broken:
https://paste.opensuse.org/view/raw/84899108

It will shift the table output and create longer lines than the
terminal width generating linebreaks and breaking the readability of
the table.

I was able to reproduce this issue with util-linux-2.32.

Regards,
Dominik
