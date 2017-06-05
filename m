Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbdFELow (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Jun 2017 07:44:52 -0400
Date: Mon, 5 Jun 2017 13:44:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Sebastian Schrader <sebastian.schrader@ossmail.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] setpriv: Add --init-groups option
Message-ID: <20170605114446.i2ocxojdumfuaan2@ws.net.home>
References: <m3mv9sernm.fsf@gmail.com>
 <20170601145210.9588-1-sebastian.schrader@ossmail.de>
 <20170601145210.9588-2-sebastian.schrader@ossmail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170601145210.9588-2-sebastian.schrader@ossmail.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 01, 2017 at 04:52:10PM +0200, Sebastian Schrader wrote:
> Add an --init-groups option which initializes the supplementary groups
> from the system's group database (e.g /etc/group) using initgroups(3).
> ---
>  sys-utils/setpriv.1 |  8 ++++++
>  sys-utils/setpriv.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 78 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
