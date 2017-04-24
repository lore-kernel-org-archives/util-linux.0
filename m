Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166769AbdDXKA0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Apr 2017 06:00:26 -0400
Date: Mon, 24 Apr 2017 12:00:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/10] libblkid: add blkid_return_known_pttypes()
Message-ID: <20170424100021.kkxu56sqbhaqeiu4@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi>
 <20170423205821.7444-5-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170423205821.7444-5-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 23, 2017 at 09:58:15PM +0100, Sami Kerola wrote:
> This new function will return list partition types names libblkid is aware
> of.  First use of this information will be in partx(8) to make bash
> completion to work without a magic list.

 See blkid_superblocks_get_name(), I think we can add the same
 function for partitions, blkid_partitions_get_name().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
