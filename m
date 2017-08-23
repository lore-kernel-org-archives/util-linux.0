Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbdHWMnB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 Aug 2017 08:43:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39B4283F42
        for <util-linux@vger.kernel.org>; Wed, 23 Aug 2017 12:43:01 +0000 (UTC)
Received: from ws.net.home (ovpn-117-68.ams2.redhat.com [10.36.117.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A7A60C28
        for <util-linux@vger.kernel.org>; Wed, 23 Aug 2017 12:42:59 +0000 (UTC)
Date: Wed, 23 Aug 2017 14:42:55 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: su refactoring and --pty implemenation
Message-ID: <20170823124255.cw6fv33alrrfcppl@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 In the last releases we ignore TIOCSTI su(1) issue. The issue is that
 (unprivileged) bad user can inject command to the privileged terminal.
 For more details see tests/helpers/test_tiocsti.c.

 The easy way how fix this issue is setsid() syscall; unfortunately
 it's bad idea in some cases (for example if you want to run su(1)
 session on background).
 
 And setsid() fixes TIOCSTI issue only. The core of the problem is
 that we share terminal file descriptors between privileged and
 unprivileged sessions.
 
 The real solution seems to be create independent pseudo-terminal for
 all the session and proxy (copy) stdin and stdout between original
 terminal and su(1) session terminal.

 I have created two branches:

 * su-refact: https://github.com/karelzak/util-linux/tree/su-refact
              https://github.com/karelzak/util-linux/commits/su-refact

   This branch does NOT introduce any change or a new feature to
   su(1). All the changes are about refactoring to make later feature
   improvements more easy to implement.

 * su-pty: https://github.com/karelzak/util-linux/tree/su-pty
           https://github.com/karelzak/util-linux/commits/su-refact

   This branch implements a new --pty command line option and it's
   based on su-refact. The new feature is marked as experimental and
   not enabled as default. It means all the current use-cases (scripts,
   ...) should not be affected by the new feature.


 I'd like to ask for review, the number of patches is large, so it's
 probably better to use git-hub. Please ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
