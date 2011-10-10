Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab1JJL21 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 07:28:27 -0400
Date: Mon, 10 Oct 2011 13:28:24 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] retire mandoc groff syntax
Message-ID: <20111010112824.GB17242@nb.net.home>
References: <CAG27Bk1KR_OKDavZV+vLspWEFQBz71ggGcif+1ir6VG7eEQKmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1KR_OKDavZV+vLspWEFQBz71ggGcif+1ir6VG7eEQKmw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 29, 2011 at 11:06:09PM +0200, Sami Kerola wrote:
>  fsck/fsck.8                                |   58 ++--
>  login-utils/vipw.8                         |   76 ++--
>  misc-utils/logger.1                        |  176 +++++-----
>  sys-utils/Makefile.am                      |    2 +-
>  sys-utils/{chcpu.1 => chcpu.8}             |    2 +-
>  sys-utils/{readprofile.1 => readprofile.8} |    3 +-
>  sys-utils/renice.1                         |  180 ++++------
>  term-utils/script.1                        |  189 +++++-----
>  term-utils/scriptreplay.1                  |  192 ++---------
>  term-utils/wall.1                          |   92 +++---
>  text-utils/col.1                           |  180 +++++-----
>  text-utils/colcrt.1                        |  119 +++----
>  text-utils/colrm.1                         |   69 ++--
>  text-utils/hexdump.1                       |  525 ++++++++++++++--------------
>  text-utils/more.1                          |  285 +++++++++-------
>  text-utils/rev.1                           |   40 +--
>  text-utils/ul.1                            |  137 ++++----
>  17 files changed, 1109 insertions(+), 1216 deletions(-)
>  rename sys-utils/{chcpu.1 => chcpu.8} (98%)
>  rename sys-utils/{readprofile.1 => readprofile.8} (98%)

 Merged, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
