Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934089AbeEJJoo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 May 2018 05:44:44 -0400
Date: Thu, 10 May 2018 11:44:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Avoid use of the old CPU macros
Message-ID: <20180510094441.j6afgsos5m4h4ozt@ws.net.home>
References: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 09, 2018 at 06:08:32PM +0200, Stanislav Brabec wrote:
>  sys-utils/chcpu.c |  6 +++---
>  sys-utils/lscpu.c | 13 +++++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)

All the patches applied. Thanks (and thanks to Michael for review).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
