Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760Ab1FHLLQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jun 2011 07:11:16 -0400
Date: Wed, 8 Jun 2011 13:11:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Sami Kerola <sami.kerola@tomtom.com>
Subject: Re: [PATCH] tests: add lscpu dumps from three Dell's & a Xen
Message-ID: <20110608111104.GA11003@nb.net.home>
References: <1306866685-2507-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306866685-2507-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 31, 2011 at 08:31:25PM +0200, Sami Kerola wrote:
>  tests/expected/lscpu/lscpu-x86_64-dell_e4310       |   28 ++++++++++++++
>  .../expected/lscpu/lscpu-x86_64-dell_poweredge1950 |   23 +++++++++++
>  .../expected/lscpu/lscpu-x86_64-dell_poweredgeR610 |   40 ++++++++++++++++++++
>  tests/expected/lscpu/lscpu-x86_64-el5xen           |   30 +++++++++++++++
>  tests/ts/lscpu/dumps/x86_64-dell_e4310.tar.gz      |  Bin 0 -> 12933 bytes
>  .../lscpu/dumps/x86_64-dell_poweredge1950.tar.gz   |  Bin 0 -> 1492 bytes
>  .../lscpu/dumps/x86_64-dell_poweredgeR610.tar.gz   |  Bin 0 -> 14095 bytes
>  tests/ts/lscpu/dumps/x86_64-el5xen.tar.gz          |  Bin 0 -> 7296 bytes
>  8 files changed, 121 insertions(+), 0 deletions(-)
>  create mode 100644 tests/expected/lscpu/lscpu-x86_64-dell_e4310
>  create mode 100644 tests/expected/lscpu/lscpu-x86_64-dell_poweredge1950
>  create mode 100644 tests/expected/lscpu/lscpu-x86_64-dell_poweredgeR610
>  create mode 100644 tests/expected/lscpu/lscpu-x86_64-el5xen
>  create mode 100644 tests/ts/lscpu/dumps/x86_64-dell_e4310.tar.gz
>  create mode 100644 tests/ts/lscpu/dumps/x86_64-dell_poweredge1950.tar.gz
>  create mode 100644 tests/ts/lscpu/dumps/x86_64-dell_poweredgeR610.tar.gz
>  create mode 100644 tests/ts/lscpu/dumps/x86_64-el5xen.tar.gz

 Applied, thanks

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
