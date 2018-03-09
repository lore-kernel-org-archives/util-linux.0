Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751190AbeCIMhU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Mar 2018 07:37:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F9DA76FBA
        for <util-linux@vger.kernel.org>; Fri,  9 Mar 2018 12:37:19 +0000 (UTC)
Date: Fri, 9 Mar 2018 13:37:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Tony Asleson <tasleson@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libblkid: ignore private Stratis devices
Message-ID: <20180309123716.knvvh2dea42hcx66@ws.net.home>
References: <20180308214126.29589-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308214126.29589-1-tasleson@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 08, 2018 at 03:41:26PM -0600, Tony Asleson wrote:
>  disk-utils/fdisk-list.c |  2 +-
>  include/sysfs.h         |  2 +-
>  lib/sysfs.c             | 24 ++++++++++++++++--------
>  libblkid/src/probe.c    |  4 ++--
>  libblkid/src/verify.c   |  2 +-
>  5 files changed, 21 insertions(+), 13 deletions(-)
 
 Applied, thanks.

 (We're before release, but it's one strncmp(), so not problem...)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
