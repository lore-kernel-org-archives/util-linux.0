Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBAO6N (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Feb 2018 09:58:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44ED6C05FEF2
        for <util-linux@vger.kernel.org>; Thu,  1 Feb 2018 14:58:13 +0000 (UTC)
Received: from ws.net.home (ovpn-117-78.ams2.redhat.com [10.36.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 959A9620D8
        for <util-linux@vger.kernel.org>; Thu,  1 Feb 2018 14:58:12 +0000 (UTC)
Date: Thu, 1 Feb 2018 15:58:09 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: failed exec() exit codes
Message-ID: <20180201145809.jjtadzla22wlw7rv@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



Now we use on many places where commands executing another command:

    execvp(argv[optind], argv + optind);
    err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);

the problem is that EXIT_FAILURE is too generic and it does not
provide any way how to detect failed exec()s.

I have added a new macro errexec() to replace err(EXIT_FAILURE, ...).

The new macro is compatible with coreutils way:

    #define EX_EXEC_FAILED          126     /* Program located, but not usable. */
    #define EX_EXEC_ENOENT          127     /* Could not find program to exec.  */

    #define errexec(name)   err(errno == ENOENT ? EX_EXEC_ENOENT : EX_EXEC_FAILED, \ 
                        _("failed to execute %s"), name)

Example:

        $ taskset -c 1 ./foo; echo $?
        taskset: failed to execute ./foo: No such file or directory
        127

        $ touch foo

        $ taskset -c 1 ./foo; echo $?
        taskset: failed to execute ./foo: Permission denied
        126


We had discussion about it 2 years ago, but it has never been
implemented and merged. Fixed now ;-)

Objections? 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
