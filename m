Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbdCWL6a (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Mar 2017 07:58:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CC8C3D941
        for <util-linux@vger.kernel.org>; Thu, 23 Mar 2017 11:58:30 +0000 (UTC)
Date: Thu, 23 Mar 2017 12:58:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] fincore command
Message-ID: <20170323115825.paxktr7xxgevrcju@ws.net.home>
References: <20170307023352.7340-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 07, 2017 at 11:33:48AM +0900, Masatake YAMATO wrote:
>  bash-completion/Makemodule.am |   3 +
>  bash-completion/fincore       |  25 +++++
>  configure.ac                  |   4 +
>  misc-utils/Makemodule.am      |   6 ++
>  misc-utils/fincore.1          |  76 ++++++++++++++
>  misc-utils/fincore.c          | 209 +++++++++++++++++++++++++++++++++++++
>  misc-utils/fincore_orig.c     | 235 ++++++++++++++++++++++++++++++++++++++++++
>  tests/commands.sh             |   1 +
>  tests/expected/fincore/count  |  62 +++++++++++
>  tests/ts/fincore/count        | 194 ++++++++++++++++++++++++++++++++++
>  10 files changed, 815 insertions(+)
>  create mode 100644 bash-completion/fincore
>  create mode 100644 misc-utils/fincore.1
>  create mode 100644 misc-utils/fincore.c
>  create mode 100644 misc-utils/fincore_orig.c
>  create mode 100644 tests/expected/fincore/count
>  create mode 100755 tests/ts/fincore/count

 Merged (except fincore_orig.c).

 I'll very probably a little bit play with the output :-) It's like to
 have human readable sizes (10M) by default, align the numbers to the
 right (maybe use libsmartcols if more files specified).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
