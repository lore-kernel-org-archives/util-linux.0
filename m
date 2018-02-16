Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932979AbeBPJyf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 16 Feb 2018 04:54:35 -0500
Date: Fri, 16 Feb 2018 10:54:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: util-linux@vger.kernel.org, Hornseth_Brenan@bah.com
Subject: Re: [PATCH] fsck: use xasprintf to avoid buffer overruns with an
 insane fs type
Message-ID: <20180216095431.wqihpps4yxavmfgf@ws.net.home>
References: <20180215200508.1466-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180215200508.1466-1-tytso@mit.edu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 15, 2018 at 03:05:08PM -0500, Theodore Ts'o wrote:
>  disk-utils/fsck.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
