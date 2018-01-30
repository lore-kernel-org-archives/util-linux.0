Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeA3LY0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 06:24:26 -0500
Date: Tue, 30 Jan 2018 12:24:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] configure: fix bashisms
Message-ID: <20180130112423.kujmjkjvexyxg73t@ws.net.home>
References: <20180125042149.17476-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125042149.17476-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 11:21:49PM -0500, Mike Frysinger wrote:
> The `test` command only recognizes =, not ==.

Ah, sorry. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
