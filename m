Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbdFTI4O (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 04:56:14 -0400
Date: Tue, 20 Jun 2017 10:56:10 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/12] hwclock: remove unused usage() FILE argument
Message-ID: <20170620085610.5eacn7kl5agfemmk@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
>  sys-utils/hwclock.c | 74 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)

It would be better to remove this patch from the pull-request; let's
keep fputs() in the code and wait for any solution from Rudi :-)

It's bad ideal to introduce any local (hwclock-only) solution right
now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
