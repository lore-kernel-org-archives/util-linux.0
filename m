Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdAPL3b (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Jan 2017 06:29:31 -0500
Date: Mon, 16 Jan 2017 12:29:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] fix side effects of loop reuse
Message-ID: <20170116112929.eac4junhawayu6wm@ws.net.home>
References: <47fc1410-17bf-6fe2-a396-93cf47ab6ac2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47fc1410-17bf-6fe2-a396-93cf47ab6ac2@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 12, 2017 at 03:45:07PM +0100, Stanislav Brabec wrote:
> -	if (backing_file) {
> +	if (backing_file && !loopval) {

This is not so bad solution, if you use -oloop=/dev/loopN you probably
know what are you doing :-)

Anyway, all the three patches applied. Thanks (and extra thank for the
tests).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
