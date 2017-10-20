Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58935 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751967AbdJTKpT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 20 Oct 2017 06:45:19 -0400
Date: Fri, 20 Oct 2017 12:45:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: util-linux@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] lsmem/chmem: add memory zone awareness
Message-ID: <20171020104514.z6bsu5vx5hgh46v5@ws.net.home>
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
> 
> Andre Wild (1):
>   lsmem/chmem: add memory zone awareness to bash-completion
> 
> Gerald Schaefer (2):
>   lsmem/chmem: add memory zone awareness
>   tests/lsmem: update lsmem test with ZONES column

Merged to the master branch.

I have added a new --split=<list> command line option to the lsmem.

It allows to control the way how lsmem merges memory blocks to the
ranges. The default is to use differences in STATE,REMOVABLE,NODE and
ZONES attributes. The ranges are no more affected by --output, it
means commands like

    lsmem --output=RANGE
    lsmem --output=RANGE,ZONES

returns the same memory ranges. You have to use --split to define your
policy:

    lsmem --split=REMOVABLE,STATE

will create the ranges according to REMOVABLE and STATE attributes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
