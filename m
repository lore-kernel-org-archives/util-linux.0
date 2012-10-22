Return-Path: svenkatr@ti.com
From: Venkatraman S <venkat@linaro.org>
To: <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <arnd.bergmann@linaro.org>,
        Venkatraman S
	<venkat@linaro.org>
Subject: [RFC PATCH 0/4] Adding useful information into swap partition header
Date: Mon, 22 Oct 2012 22:27:23 +0530
Message-ID: <1350925048-31084-1-git-send-email-venkat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <util-linux.vger.kernel.org>

Trying some of the ideas bounced around in lkml for
optimizing swap on flash (eMMC / SD) media [1], we can start
to add useful information into swapheader without breaking
compatibility.
Such information can help the kernel swap management algo
to tune itself to the geometry of flash devices (erase block
size and page size etc).
Some more features (like command line override) are still 
under development. In long term, libblkid/mkswap can be extended
to even detect this information by timing attacks,
even if sysfs parameters are not present.


Venkatraman S (4):
  libblkid/topology: add preferred_erase_size to topology probe
  mkswap: refactor header preparation
  mkswap: Add additional fields in swapheader
  mkswap: Probe and embed useful block device info into swapheader

 disk-utils/mkswap.c              | 77 ++++++++++++++++++++++++++++++++--------
 include/swapheader.h             |  7 +++-
 libblkid/src/topology/sysfs.c    |  1 +
 libblkid/src/topology/topology.c | 19 ++++++++++
 libblkid/src/topology/topology.h |  1 +
 5 files changed, 90 insertions(+), 15 deletions(-)

-- 
1.7.11.1.25.g0e18bef
