Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbdJBLMi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 07:12:38 -0400
Date: Mon, 2 Oct 2017 13:12:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: util-linux@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] lsmem/chmem: add memory zone awareness
Message-ID: <20171002111231.z4ibknsg2gmvx53y@ws.net.home>
References: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 27, 2017 at 07:44:43PM +0200, Gerald Schaefer wrote:
> These patches are against lsmem/chmem in util-linux, they add support
> for listing and changing memory zone allocation.
> 
> Added Michal Hocko and linux-mm on cc, to raise general awareness for
> the lsmem/chmem tools, and the new memory zone functionality in
> particular. I think this can be quite useful for memory hotplug kernel
> development, and if not, sorry for the noise.

Seems good.

I'll merge it (probably with some minor changes:-) after v2.31
release. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
