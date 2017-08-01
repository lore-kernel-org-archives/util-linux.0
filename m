Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdHAJvZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 05:51:25 -0400
Date: Tue, 1 Aug 2017 11:51:21 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Pull Request
Message-ID: <20170801095121.55s26xvmdoq4vfml@ws.net.home>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 31, 2017 at 07:36:22PM -0400, J William Piggott wrote:
>       hwclock: squash custom errno strings
>       hwclock: squash custom errno strings
>       hwclock: fix unimplemented ioctl test
>       hwclock: remove custom errno string
>       hwclock: remove custom errno string

 Cool, I like it a lot. This is exactly how error/warning messages
 should be composed. Don't guess anything, don't try to explain
 everything, etc ... just print errno based string.

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
