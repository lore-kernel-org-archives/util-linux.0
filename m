Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbdIRLOD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Sep 2017 07:14:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91EB9C00DB86
        for <util-linux@vger.kernel.org>; Mon, 18 Sep 2017 11:14:03 +0000 (UTC)
Received: from ws.net.home (ovpn-117-220.ams2.redhat.com [10.36.117.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02C275C3FA
        for <util-linux@vger.kernel.org>; Mon, 18 Sep 2017 11:14:02 +0000 (UTC)
Date: Mon, 18 Sep 2017 13:13:58 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: su refactoring and --pty implemenation
Message-ID: <20170918111358.yqhbl7w4jz5megab@ws.net.home>
References: <20170823124255.cw6fv33alrrfcppl@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823124255.cw6fv33alrrfcppl@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 23, 2017 at 02:42:55PM +0200, Karel Zak wrote:
>  * su-pty: https://github.com/karelzak/util-linux/tree/su-pty
>            https://github.com/karelzak/util-linux/commits/su-refact
> 
>    This branch implements a new --pty command line option and it's
>    based on su-refact. The new feature is marked as experimental and
>    not enabled as default. It means all the current use-cases (scripts,
>    ...) should not be affected by the new feature.

Merged.

Fast-forward
 include/Makemodule.am     |    1 +
 include/pwdutils.h        |   11 +
 lib/Makemodule.am         |    5 +
 lib/pwdutils.c            |   96 ++++++++
 login-utils/Makemodule.am |    6 +
 login-utils/login.c       |   29 +--
 login-utils/logindefs.c   |   13 +-
 login-utils/logindefs.h   |    2 +-
 login-utils/su-common.c   | 2107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
 login-utils/su.1          |   14 +-
 term-utils/script.c       |   11 +-
 11 files changed, 1429 insertions(+), 866 deletions(-)
 create mode 100644 include/pwdutils.h
 create mode 100644 lib/pwdutils.c


Thanks all for review. We'll see...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
