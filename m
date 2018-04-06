Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751492AbeDFK7S (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 6 Apr 2018 06:59:18 -0400
Date: Fri, 6 Apr 2018 12:59:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: Return EXIT_FAILURE when FTRIM ioctl fails
Message-ID: <20180406105915.us6vsmyhfxhbsegx@ws.net.home>
References: <20180405180006.213759-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180405180006.213759-1-gwendal@chromium.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2018 at 11:00:06AM -0700, Gwendal Grignou wrote:
> commit 36c370cbf1481aa8724dff8b7b7fec4a8ba9930b add fstrim_filesystem
> that return -1 or 1 depending on the FTRIM ioctl failures.
> Without this change, main() returns -1 if the fstrim_filesystem()
> returns -1.
> Returns EXIT_FAILURE in both cases.

Good catch. Thanks!

I have applied a little bit different solution:
https://github.com/karelzak/util-linux/commit/7afdbb6f0760952c6e4f86d4c73442d1caee96a8

It seems better to not play any games with fstrim_all() return codes
in main() as the function fstrim_all() return MNT_EX_* codes. 

Anyway, I prefer to use EXIT_* macros in main() only.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
