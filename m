Return-Path: util-linux-owner@vger.kernel.org
Received: from bombadil.infradead.org ([198.137.202.133]:41930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeDJRLl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Apr 2018 13:11:41 -0400
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: kernel bugzilla entries for util-linux
Message-ID: <fb5b024f-575b-cbf2-4170-b7c7239946d3@infradead.org>
Date: Tue, 10 Apr 2018 10:11:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

There are a number of util-linux related bug entries at https://bugzilla.kernel.org/,
mostly in the Tools/Other category.

Can I do anything with these?

E.g., I could add a comment in each one of them to report the bug/request to
the util-linux mailing list.

Or I could forward each one individually to the util-linux mailing list.

Or I could ignore them. :)

If any of these have already been fixed, I can also mark them closed/fixed,
although it would be better to have a commit ID or release version info for
the fix.

thanks,
-- 
~Randy


summary:

Bug 199079 - blkid reports that a disk that once was a zfs pool, but is not anymore, is still a zfs pool
Bug 198565 - [util-linux] gid lookups with getgrnam_r() should handle an ERANGE error, by retrying with a larger buffer.
Bug 198039 - [util-linux] look parameter for giving back line numbers.
Bug 198011 - [util-linux] look is ignoring locale.
Bug 197471 - fdisk does not display c/h/s values correctly
Bug 194857 - building util-linux-2.29.2 doesn't seem to be including libs from <proj>/lib @ link
Bug 117261 - util-linux's cal gives wrong leap years before 1800
Bug 108521 - [util-linux] column -s X -t fails when there are colour escapes before X
Bug 100021 - [util-linux] v2.24 ... v2.26.2: bug in regression test script for partx
Bug 93981 - [util-linux] login, shells, file paths, and the /usr/bin/ merge
Bug 101111 - [util-linux] scriptreplay replays typescript created by "script -q" wrongly

