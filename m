Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64345 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754620AbdJRLkO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 18 Oct 2017 07:40:14 -0400
Date: Wed, 18 Oct 2017 13:40:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: util-linux@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andre Wild <wild@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] lsmem/chmem: add memory zone awareness
Message-ID: <20171018114009.7b4iax6536un5bnr@ws.net.home>
References: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 27, 2017 at 07:44:43PM +0200, Gerald Schaefer wrote:
>  bash-completion/chmem                  |   1 +
>  bash-completion/lsmem                  |   2 +-
>  sys-utils/chmem.8                      |  19 +++++
>  sys-utils/chmem.c                      | 136 +++++++++++++++++++++++++++++++--
>  sys-utils/lsmem.1                      |   4 +-
>  sys-utils/lsmem.c                      |  98 +++++++++++++++++++++++-
>  tests/expected/lsmem/lsmem-s390-zvm-6g |  21 +++++
>  tests/expected/lsmem/lsmem-x86_64-16g  |  39 ++++++++++
>  tests/ts/lsmem/lsmem                   |   1 +
>  9 files changed, 309 insertions(+), 12 deletions(-)

Merged to my "next" branch (in master we have still feature-freeze).

I have also added a note about the way how lsmem merges blocks to
create the RANGE column. It seems important, because the number of
ranges is affected by ZONES (or REMOVABLE). See:

  https://github.com/karelzak/util-linux/commit/ffe5267c91018ca8cac8bedc14b695478c11a5dd

Maybe it's possible to explain it in a better way... (send patch;-)

The another possibility is to *always use* zones and removable
attributes to create the ranges (merge blocks) independently on the
output columns (e.g. -o ZONES). So, the result will be always the same
number of ranges with the same <start>-<end>. 

Now (see the first range):

$ lsmem 
RANGE                                  SIZE  STATE REMOVABLE  BLOCK
0x0000000000000000-0x0000000047ffffff  1.1G online        no    0-8
0x0000000048000000-0x0000000057ffffff  256M online       yes   9-10
0x0000000058000000-0x000000005fffffff  128M online        no     11
0x0000000060000000-0x0000000067ffffff  128M online       yes     12
0x0000000068000000-0x0000000087ffffff  512M online        no  13-16
0x0000000088000000-0x000000008fffffff  128M online       yes     17
0x0000000090000000-0x00000000afffffff  512M online        no  18-21
0x00000000b0000000-0x00000000bfffffff  256M online       yes  22-23
0x0000000100000000-0x000000042fffffff 12.8G online        no 32-133
0x0000000430000000-0x0000000437ffffff  128M online       yes    134
0x0000000438000000-0x000000043fffffff  128M online        no    135

lsmem -o+ZONES
RANGE                                  SIZE  STATE REMOVABLE  BLOCK  ZONES
0x0000000000000000-0x0000000007ffffff  128M online        no      0   None
0x0000000008000000-0x0000000047ffffff    1G online        no    1-8  DMA32
0x0000000048000000-0x0000000057ffffff  256M online       yes   9-10  DMA32
0x0000000058000000-0x000000005fffffff  128M online        no     11  DMA32
0x0000000060000000-0x0000000067ffffff  128M online       yes     12  DMA32
0x0000000068000000-0x0000000087ffffff  512M online        no  13-16  DMA32
0x0000000088000000-0x000000008fffffff  128M online       yes     17  DMA32
0x0000000090000000-0x00000000afffffff  512M online        no  18-21  DMA32
0x00000000b0000000-0x00000000bfffffff  256M online       yes  22-23  DMA32
0x0000000100000000-0x000000042fffffff 12.8G online        no 32-133 Normal
0x0000000430000000-0x0000000437ffffff  128M online       yes    134 Normal
0x0000000438000000-0x000000043fffffff  128M online        no    135   None

lsmem -oRANGE,SIZE
RANGE                                 SIZE
0x0000000000000000-0x00000000bfffffff   3G
0x0000000100000000-0x000000043fffffff  13G


I didn't test it, but the question is how usable is 
0x0000000000000000-<end> as option for chmem.

It's also seems difficult to use it in scripts if you want to output only
a RANGE, for example

    FOO=$(lsmem -oRANGE -n --summary=never | head -1)
    
but the range is affected by missing columns.

Comments?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
