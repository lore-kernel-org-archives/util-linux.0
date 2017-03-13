Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbdCMOuq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 10:50:46 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0737280462
        for <util-linux@vger.kernel.org>; Mon, 13 Mar 2017 14:50:46 +0000 (UTC)
Date: Mon, 13 Mar 2017 15:50:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] fincore command
Message-ID: <20170313145041.senno5cucpkp6s57@ws.net.home>
References: <20170307023352.7340-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 07, 2017 at 11:33:48AM +0900, Masatake YAMATO wrote:
> This patch set proposes adding fincore command to util-linux
> distribution.  The command counts pages of file contents being
> resident in memory(in core), and reports the numbers.
> 
> It helps system administrators understand how their systems use
> physical memory, especially about page caches when they have to do
> trouble shooting and/or performance tuning.
> 
> This is just my case. A person in other role may also get benefits
> from this command.

Not sure if I like the format ;-)

 $ fincore /etc/fstab /bin/emacs
 1          1544       /etc/fstab
 4156       17163144   /bin/emacs

Why we need file size there? Would be better to use filename as the
first column?

 $ fincore /etc/fstab /bin/emacs
 /etc/fstab 1
 /bin/emacs 4156

it would be also nice have a way how to print only the number if only one
file specified. Then you can use it in scripts without awk (or so),
just:

  FILEPAGES=$(fincore /bin/emacs)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
