Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbeJDQvc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 4 Oct 2018 12:51:32 -0400
Date: Thu, 4 Oct 2018 11:58:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] Fixes for v2.33 on musl-based systems
Message-ID: <20181004095859.yqeimaqcuwaduxls@ws.net.home>
References: <cover.1537942755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1537942755.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 26, 2018 at 08:23:07AM +0200, Patrick Steinhardt wrote:
> Patrick Steinhardt (2):
>   lsblk: fix unknown type `stat` caused by missing header
>   rename: avoid undefined function prototype for `fpurge`

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
