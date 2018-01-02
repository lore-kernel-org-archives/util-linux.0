Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeABKNL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 05:13:11 -0500
Date: Tue, 2 Jan 2018 11:13:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux 2.31 testsuite failures
Message-ID: <20180102101307.qybdwo73h36otqgp@ws.net.home>
References: <m21sjbp6v7.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m21sjbp6v7.fsf@linux-m68k.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 31, 2017 at 10:46:36AM +0100, Andreas Schwab wrote:
> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:PowerPC/util-linux/standard/ppc
> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:PowerPC/util-linux/standard/ppc64
> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:zSystems/util-linux/standard/s390x

Ah, ...we use WORDS_BIGENDIAN rather than BYTE_ORDER. Fixed in git tree. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
