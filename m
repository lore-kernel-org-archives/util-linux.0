Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338Ab2B1NkE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 08:40:04 -0500
Date: Tue, 28 Feb 2012 14:40:01 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: autotools readability fixes
Message-ID: <20120228134001.GA22034@x2.net.home>
References: <CAG27Bk1RXEBfo6KX4_HrAuY7AGPCCKGbFBiXdd6M5rrGU5waBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1RXEBfo6KX4_HrAuY7AGPCCKGbFBiXdd6M5rrGU5waBw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 08, 2012 at 10:16:53AM +0100, Sami Kerola wrote:
>  Makefile.am                          |   22 ++--
>  config/include-Makefile.am           |    4 +-
>  configure.ac                         |  196 +++++++++++++++++-----------------
>  disk-utils/Makefile.am               |   54 +++++++--
>  fdisk/Makefile.am                    |   37 +++++--
>  hwclock/Makefile.am                  |    7 +-
>  include/Makefile.am                  |    4 +-
>  lib/Makefile.am                      |   24 +++--
>  libblkid/Makefile.am                 |    1 -
>  libblkid/samples/Makefile.am         |    7 +-
>  libblkid/src/Makefile.am             |   86 ++++++++++-----
>  libblkid/src/partitions/Makefile.am  |   33 +++---
>  libblkid/src/superblocks/Makefile.am |   92 ++++++++--------
>  libblkid/src/topology/Makefile.am    |   18 ++--
>  libmount/src/Makefile.am             |   78 +++++++++-----
>  libuuid/Makefile.am                  |    1 -
>  libuuid/man/Makefile.am              |   17 +++-
>  libuuid/src/Makefile.am              |   22 +++-
>  login-utils/Makefile.am              |   41 ++++++--
>  misc-utils/Makefile.am               |   68 ++++++++----
>  mount/Makefile.am                    |   48 +++++---
>  partx/Makefile.am                    |   23 ++--
>  schedutils/Makefile.am               |    5 +-
>  sys-utils/Makefile.am                |  102 ++++++++++++------
>  tests/Makefile.am                    |    9 +-
>  tests/helpers/Makefile.am            |    8 +-
>  text-utils/Makefile.am               |   28 ++++-
>  27 files changed, 649 insertions(+), 386 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
