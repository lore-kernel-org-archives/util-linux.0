Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752869AbeAVJBN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 04:01:13 -0500
Date: Mon, 22 Jan 2018 10:01:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount(8): drop redundant filesystem-specific sections
Message-ID: <20180122090110.vu2vbfm4wvoloime@ws.net.home>
References: <20180119184520.13067-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119184520.13067-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 19, 2018 at 01:45:20PM -0500, Mike Frysinger wrote:
> -.SS "Mount options for tmpfs"
> -.TP
> -.BI size= nbytes
> -Override default maximum size of the filesystem.
> -The size is given in bytes, and rounded up to entire pages.
> -The default is half of the memory.  The size parameter also accepts a suffix %
> -to limit this tmpfs instance to that percentage of your physical RAM:
> -the default, when neither size nor nr_blocks is specified, is size=50%

The "man tmpfs" describes the option size= only. There is no
nr_blocks=, mode=, uid=, gid= and mpol=. Is it expected? Maybe we a
patch to man-pages too.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
