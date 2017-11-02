Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932401AbdKBOAm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Nov 2017 10:00:42 -0400
Date: Thu, 2 Nov 2017 15:00:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Na Nha <minhnhan0801@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Set_disksize_zram_LTP_testsuite
Message-ID: <20171102140038.xl6m7bdb2nmllv2r@ws.net.home>
References: <CAPiF6Th05_w6xE49Sym2XNLQrDPvrQ+74N1EcL2w9SESQ5ZpaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPiF6Th05_w6xE49Sym2XNLQrDPvrQ+74N1EcL2w9SESQ5ZpaA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 23, 2017 at 11:48:25PM +0700, Na Nha wrote:
> My name is Le Minh nhan, I am a Linux developer.
> 
> When I had used LTP testsuite to test our kernel, I encountered an error.
> Testcase "zram02" of LTP testsuite  sets 100G disksize to zram, the
> kernel says "cannot allocate memory". But there is no problem if I use
> other values: 10G,20G...90G to set disksize of zram.

The command zramctl uses 64-bit numbers for sizes, so it's without any
limitation, but don't forget that kernel uses RAM to allocate it...
see

 https://www.kernel.org/doc/Documentation/blockdev/zram.txt

where is more details about the limits, some of the limits is possible
set by /sys.

Note that zramctl --size modifies disksize attribute only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
