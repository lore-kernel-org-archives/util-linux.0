Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbcDRSAV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 14:00:21 -0400
Date: Mon, 18 Apr 2016 20:00:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>,
        Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] libblkid: make blkid_do_wipe() work with probes with
 offset
Message-ID: <20160418180018.wgjfgaule76mcfyb@ws.net.home>
References: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 18, 2016 at 04:22:05PM +0200, Petr Uzel wrote:
> When a probe is created with an offset, e.g. via
> blkid_probe_set_device(), this offset is correctly used when looking for
> the signatures, but is not respected by blkid_do_wipe() function.
> Therefore the signature is removed from an invalid location.

Wow, excellent catch. 

How did you found it? Do you use libblkid in some partitioning tool or
installer?

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
